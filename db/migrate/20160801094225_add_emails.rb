class AddEmails < ActiveRecord::Migration

  def up
    execute %q{
      create table email_domains(
        id smallserial primary key,
        domain varchar not null
      );

      create table emails(
        id serial primary key,
        username varchar not null,
        domain_id smallint not null references email_domains(id),
        employee_id integer references employees(id),
        password varchar not null
      );
      create unique index on emails(username, domain_id);
    }
  end

  def down
    execute %q{
      drop table emails;
      drop table email_domains;
    }
  end

end
