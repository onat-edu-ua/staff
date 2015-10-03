class AddType < ActiveRecord::Migration
  def up
    execute "
    create table employee_positions(
      id smallserial primary key,
      name varchar not null unique
    );

    alter table employees add position_id smallint not null references employee_positions(id);
"
  end

  def down

    execute "
    alter table employees drop column position_id;
    drop table employee_positions;
"
  end
end