class EmailProceduresPort < ActiveRecord::Migration
  def change

    # change to email_domains table
    change_table :email_domains do |t|
      t.column :create_date, 'timestamp with time zone'
      t.boolean :active, default: true
    end

    reversible do |dir|
      dir.up do
        execute "ALTER TABLE email_domains ALTER COLUMN create_date SET DEFAULT now()"
      end
    end

    add_index :email_domains, :domain, unique: true

    # create email_redirects table
    create_table :email_redirects do |t|
      t.string :dst, limit: 128
      t.string :rewrite_dst, limit: 128
      t.text :description
      t.column :create_date, 'timestamp with time zone'
    end

    reversible do |dir|
      dir.up do
        execute "ALTER TABLE email_redirects ALTER COLUMN create_date SET DEFAULT now()"
      end
    end

    add_index :email_redirects, :dst, unique: true
    add_index :email_redirects, [:dst, :rewrite_dst], unique: true

    # change to emails table
    change_table :emails do |t|
      t.column :create_date, 'timestamp with time zone'
      t.boolean :active, default: true
    end

    reversible do |dir|
      dir.up do
        execute "ALTER TABLE emails ALTER COLUMN create_date SET DEFAULT now()"
      end
    end

    add_index :emails, [:username, :domain_id], unique: true
    add_index :emails, [:username, :active, :domain_id]
    add_index :emails, [:username, :active]

    #functions
    say "creating func relay_to_domains_query_f", true
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE OR REPLACE FUNCTION relay_to_domains_query_f(domain_p varchar)
          RETURNS varchar
          LANGUAGE plpgsql
          AS $$
          DECLARE
            res_v character varying;
          BEGIN
            SELECT t1.domain INTO res_v FROM email_domains t1
            WHERE t1.domain=domain_p AND t1.active='1';
            RETURN res_v ;
          END;
          $$;
        SQL
      end
      dir.down do
        execute <<-SQL
          DROP FUNCTION relay_to_domains_query_f(varchar);
        SQL
      end
    end

    say "creating func search_user_query_f", true
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE OR REPLACE FUNCTION search_user_query_f(local_part_p varchar, domain_p varchar)
          RETURNS character varying
          LANGUAGE plpgsql
          AS $$
          DECLARE
            res_v character varying;
          BEGIN
            local_part_p=replace(local_part_p,'\','');
            domain_p=replace(domain_p,'\','');
            SELECT username||'@'||domain INTO res_v
            FROM emails te JOIN email_domains td ON te.domain_id=td.id
            WHERE te.username = local_part_p AND
              td.domain = domain_p AND
              te.active='1' AND
              td.active='1'
            UNION
            SELECT dst FROM email_redirects WHERE dst=local_part_p||'@'||domain_p;
            RETURN res_v ;
          END;
          $$;
        SQL
      end
      dir.down do
        execute <<-SQL
          DROP FUNCTION search_user_query_f(varchar, varchar);
        SQL
      end
    end

    say "creating func everyone", true
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE OR REPLACE FUNCTION everyone(i_domain varchar, i_sender varchar)
          RETURNS SETOF varchar
          LANGUAGE plpgsql
          AS $$
          DECLARE
          BEGIN
            IF i_sender IN ('admin@onat.edu.ua',
                            'vadim.kaptur@onat.edu.ua',
                            'perekrestov.igor@onat.edu.ua',
                            'rdd@onat.edu.ua') THEN
            RETURN QUERY SELECT (acc.username||'@'||"domain")::varchar
            FROM emails acc
            JOIN email_domains domains ON acc.domain_id=domains.id
            WHERE domains.domain=i_domain and acc.username!='everyone';
            END IF;
            RETURN;
          END;
          $$;
        SQL
      end
      dir.down do
        execute <<-SQL
          DROP FUNCTION everyone(varchar, varchar);
        SQL
      end
    end

    say "creating func get_email_rewrite_dst", true
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE FUNCTION get_email_rewrite_dst(destination varchar)
          RETURNS varchar
          LANGUAGE PLPGSQL
          AS $$
          DECLARE
            result varchar;
          BEGIN
            SELECT rewrite_dst AS goto INTO result
            FROM email_redirects
            WHERE dst=destination;
            RETURN result;
          END;
          $$;
        SQL
      end
      dir.down do
        execute <<-SQL
          DROP FUNCTION get_email_rewrite_dst(varchar)
        SQL
      end
    end
  end
end
