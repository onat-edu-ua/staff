class AddDepartments < ActiveRecord::Migration
  def up
    execute "create table departments(
      id serial primary key,
      name varchar not null unique
    );
"
  end

  def down
    execute "drop table departments"
  end
end
