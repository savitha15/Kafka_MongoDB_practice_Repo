use contactData

db.persons.insertOne({
    name:"Savi",
    age:22,
    hobbies:["gardening","music"]
})

db.persons.insertOne({
    name:"Sai",
    age:29,
    hobbies:["gardening","music"]
})

db.persons.insertMany([
    {
         name:"Rai",
        age:229,
        hobbies:["ggames","music"]
    }
])

db.persons.insertMany([
    {
         name:"priya",
        age:20,
        hobbies:["tenniss","music"]
    },
    {
         name:"Riya",
        age:30,
        hobbies:["ggames","music"]
    }
])

db.persons.insert({name:"dev",age:48})

db.persons.insert([
    {
         name:"rahul",
        age:20,
    },
    {
         name:"ram",
        age:30,
        hobbies:["ggames","music"]
    }
])

--ordered insert

db.hobbies.insertMany([{
    _id:"sports",name:"sports"
},{
    _id:"cooking",name:"cooking"
},{
    _id:"cars",name:"music"
}])

db.hobbies.insertMany([{
    _id:"yoga",name:"yoga"
},{
    _id:"cooking",name:"cooking"
},{
    _id:"trekking",name:"trekking"
}])

db.hobbies.insertMany([
    {_id:"yoga",name:"yoga"},
    {_id:"cooking",name:"cooking"},
    {_id:"trekking",name:"trekking"}
], {ordered:false})

db.hobbies.insertMany([
    {_id:"jumping",name:"jumping"},
    {_id:"dancing",name:"dancing"},
    {_id:"trekking",name:"trekking"}
], {ordered:false})

db.persons.insertOne({name:"savi",age:31},{writeConcern:{w:0}})