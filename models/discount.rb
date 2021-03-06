require_relative('../db/sqlrunner.rb')

class Discount
  attr_reader :id, :type, :multiplier
  
  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @type = options["type"]
    @multiplier = options["multiplier"].to_f
  end

  # =============================================================
  # ========================== CRUD =============================
  
  def save
    sql = "
    INSERT INTO discounts
    (name, multiplier, type)
    VALUES
    ($1, $2, $3)
    RETURNING id
    "
    values = [self.name, @multiplier, @type]
    discount = SqlRunner.run(sql, values).first
    @id = discount["id"].to_i
  end

  def self.find(id)
    sql ="
    SELECT * FROM discounts
    WHERE id = $1
    "
    values = [id]
    discount = SqlRunner.run(sql, values).first
    return Discount.new(discount)
  end

  def update
    sql = "
    UPDATE discounts
    SET (name, multiplier, type) =
    ($1, $2, $3)
    WHERE id = $4
    "
    values = [self.name, @multiplier, @type, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "
    DELETE FROM discounts
    WHERE id = $1
    "
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # =============================================================
  # ========================== ALLS =============================
  
  
  def self.delete_all
    sql = "
    DELETE FROM discounts
    "
    SqlRunner.run(sql)
  end

  def self.all
    sql = "
    SELECT * FROM discounts ORDER BY id
    "
    result = SqlRunner.run(sql)
    return result.map { |discount| Discount.new(discount) }
  end

  def self.count
    return self.all.count
  end

  def self.types
    sql = "
    SELECT DISTINCT ON (type) * FROM discounts
    "
    result = SqlRunner.run(sql)
    return result.map { |discount| Discount.new(discount) }
  end

  # =============================================================
  # ========================== INFO =============================

  def name 
    case type
    when "percentage"
      return "#{@multiplier.round(0)}\% Off"
    when "deduction"
      return "£#{@multiplier.round(0)} Off"
    end
  end

end