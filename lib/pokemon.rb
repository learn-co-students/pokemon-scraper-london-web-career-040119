class Pokemon
  attr_reader :id, :name, :type, :db, :hp

  def initialize(id: nil, name:, type:, hp: nil, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?,?);
    SQL

    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id is ? LIMIT 1;
    SQL

    pokermon_data = db.execute(sql, id).flatten

    new(id: id, name: pokermon_data[1], type: pokermon_data[2], hp: pokermon_data[3], db: db)
  end

  def alter_hp(new_hp, db)
    @hp = new_hp
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?;
    SQL

    db.execute(sql, new_hp, id)
  end
end
