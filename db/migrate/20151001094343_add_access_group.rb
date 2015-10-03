class AddAccessGroup < ActiveRecord::Migration
  def up
    execute "
    create table access_groups(
      id serial primary key,
      name varchar not null unique,
      tag varchar not null unique
    );

    create table employees(
      id serial primary key,
      first_name varchar not null,
      last_name varchar not null,
      middle_name varchar,
      department_id integer not null references departments(id),
      access_group_ids integer[],
      login varchar not null unique,
      password varchar not null
    );

"
  end

  def down

    execute "
    drop table employees;
    drop table access_groups;
"
  end
end
