class Song
  attr_accessor :name, :album, :id

  def initialize name: , album:, id: nil
    @id = id
    @name = name
    @album = album
  end

  def self.create_table
    sql = <<-SQL
     CREATE TABLE IF NOT EXISTS songs (
      id INTEGER PRIMARY KEY,
      name TEXT,
      album TEXT
     )
    SQL
    DB[:conn].execute(sql)
  end


  def save
    sql = <<-SQL
      INSERT INTO songs (name , album )
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.album)

  end

  def self.create name: , album:
    song = Song.new name: name, album: album
    song.save
  end

  #Convert what the db gives us in form of an array into a ruby obkject

  def self.new_from_db row
    Song.new id: row[0], name: row[1], album: row[2]
  end

  def self.all
    sql = <<-SQL
      SELECT * FROM songs
      SQL
      DB[:conn].execute(sql).map do |row|
        self.new_from_db row
      end
  end

  def self.find_by_name name
    sql = <<-SQL
    SELECT * FROM songs WHERE name = ?
    LIMIT 1
    SQL
    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db row
    end.first
  end


end

