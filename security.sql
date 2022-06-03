-- authentication and authorization
-- transport encryption
-- Encryption at best
-- audit
-- server network config setup
-- back up and softare updates

--authentication and authorization

-- client app -> mongo server -> db

-- Admin ,Developer ,Data Scientist

-- createUser(...)
-- updateUser(...)

mongo -u user -p pw

use Admin
show collections

db.createUser({user:"venkat",pwd:"123",roles:["userAdminAnyDatabase"]})  --run as administrator and run this query


-- no you can login as mongo -u venkat -p 123


db.createUser({user:"appdev",pwd:"dev",roles:["readWrite"]})

db.auth("appdev","dev")

db.products.insertOne({name:"book"})

 db.logout()

 db.updateUser("appdev",{roles:["readWrite",{role:"readWrite",db: "blog"}]})