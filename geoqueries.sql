use awesomeplaces

db.places.insertOne({
    name:"my first location",
    location:{
        type:"Point",
        coordinates:[77.713038,12.89048]
    }
})

db.places.find({
    location:{
        $near:{
            $geometry:{
                type:"Point",
                coordinates:[77.7139,12.90014]
            }
        }
    }
})
---if you add the geometry index only you can make geospatial queries otherwise not
db.places.createIndex({
    location:"2dsphere"
})

 db.places.getIndexes()

--after adding the above inde the belo query is working
 db.places.find({
    location:{
        $near:{
            $geometry:{
                type:"Point",
                coordinates:[77.7139,12.90014]
            }
        }
    }
})
---no places i  this max and min distance so not working
db.places.find({
    location:{
        $near:{
            $geometry:{
                type:"Point",
                coordinates:[77.7139,12.90014]
            },
            $maxDistance:30,
            $minDistance:10
        }
    }
}).pretty()

--not working because within 250 m there are places
db.places.find({
    location:{
        $near:{
            $geometry:{
                type:"Point",
                coordinates:[77.7139,12.90014]
            },
            $maxDistance:250,
            $minDistance:10
        }
    }
}).pretty()

db.places.updateOne({"geometry"},{
    $set:{
        coordinates:[77.71396,12.90014]
    }
})

