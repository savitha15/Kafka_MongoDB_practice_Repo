db.users.deleteOne({name:"krish"})


--it will delete only if age >30 and isSporty true else not
db.users.deleteMany({totalAge:{
    $gt:30
},isSporty:true})


--if totalage does not exist and isSporty true then it will delete
db.users.deleteMany({totalAge:{
    $exists:false
},isSporty:true})

db.users.deleteMany({})  --delete all record in collection

db.users.drop()  --delete user collecion indatabase
db.dropDatabase()  --drop the database
