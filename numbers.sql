---integers                     int32
---long                         int64
---doubles                      64 bit
--high precision doubles        128 bit

db.persons.insertOne({name:"venkat",age:29})  -52 bytes

db.persons.stats()

db.persons.deleteMany({})

db.persons.insertOne({age:NumberInt("29")})

db.companies.insertOne({valuation:NumberInt(2147455205567)})

db.companies.insertOne({valuation:NumberInt("2147455205567")})

db.companies.insertOne({valuation:NumberLong(214745520556723444444099999999)})