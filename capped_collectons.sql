use performance

db.createCollection("capped",{capped:true,size:10000,max:3})

db.capped.insertOne({name:"savi"})
db.capped.insertOne({name:"kavi"})
db.capped.insertOne({name:"navi"})
db.capped.insertOne({name:"pavi"})
--it ill remove the first document when we insert more capacity in this case if it exceed 3 it remove the first value that like a stack.