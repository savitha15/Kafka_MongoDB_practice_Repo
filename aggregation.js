//mongoimport persons.json -d analytics -c persons --jsonArray
//aggregation pipeline
//collection->$match->$sort->$group->$project->outut(list of documents)

//use analytics


//1st stage match in pipeline
db.persons.aggregate([{
    $match:{
        gender:"female"
    }
}])

//2nd stage group in aggregation pipeline
db.persons.aggregate([
    { $match:{
        gender:"female"
        }   
    },
    {
        $group:{
            _id:{
                state:"$location.state"
            },
                totalPersons:{
                    $sum:1
                }
        }
    }
]).pretty()

db.persons.find({"location.state":"osmaniye"}).pretty()


//3rd stage using $sort pipeline
db.persons.aggregate([
    { $match:{
        gender:"female"
        }   
    },
    {
        $group:{
            _id:{
                state:"$location.state"
            },
                totalPersons:{
                    $sum:1
                }
        },
        
    },
    {
        $sort:{
            totalPersons:-1
        }
    }
]).pretty()

//project in aggregation pipeline

db.persons.aggregate(
    {$project:{_id:0,gender:1,fullName:{$concat:["Hello"," ","World"]}} }
)


//
db.persons.aggregate(
    {
        $project:{
            _id:0,
            gender:1,
            fullName:{
                $concat:[
                    {$toUpper:'$name.first'}," ",{$toUpper:'$name.last'}
                ]
            }
        }
    }
)

//project only first letter uppercase
db.persons.aggregate(
    {
        $project:{
            _id:0,
            gender:1,
            fullName:{
                $concat:[
                    {$toUpper:{$substrCP:['$name.first',0,1]}},
                    {
                        $substrCP:[
                            '$name.first',1,
                            {
                                $subtract:[{$strLenCP:'$name.first'},1]
                            }
                        ]
                    },
                    " ",{$toUpper:{$substrCP:['$name.last',0,1]}},
                    {
                        $substrCP:[
                            '$name.last',1,
                            {
                                $subtract:[{$strLenCP:'$name.last'},1]
                            }
                        ]
                    }
                ]
            }
        }
    }
)

//turning the location into geoJSON object and we cant write queries for if coordinates in string so e change to double

db.persons.aggregate([
    {
        $project:{
            _id:0,
            name:1,
            email:1,
            birthDate:{
                $convert:{
                    input:'$dob.date',
                    to:'date'
                }
            },
            age:"$dob.age",
            location:{
                type:'Point',
                coordinates:[
                    {
                        $convert:{
                            input: '$location.coordinates.longitude',
                            to:'double',
                            onError:0.0,
                            onNull:0.0
                        }
                    },
                    {
                        $convert:{
                            input: '$location.coordinates.latitude',
                            to:'double',
                            onError:0.0,
                            onNull:0.0
                        }
                    }
                   
                    
                ]
            }
        }
    },
    {
        $project:{
            gender:1,
            email:1,
            location:1,
            birthDate:1,
            age:1,
            fullName:{
                $concat:[
                    {$toUpper:{$substrCP:['$name.first',0,1]}},
                    {
                        $substrCP:[
                            '$name.first',1,
                            {
                                $subtract:[{$strLenCP:'$name.first'},1]
                            }
                        ]
                    },
                    " ",{$toUpper:{$substrCP:['$name.last',0,1]}},
                    {
                        $substrCP:[
                            '$name.last',1,
                            {
                                $subtract:[{$strLenCP:'$name.last'},1]
                            }
                        ]
                    }
                ]
            }
        }
    }
]
).pretty()

//using shortcut to convert date
db.persons.aggregate([
    {
        $project:{
            _id:0,
            name:1,
            email:1,
            birthDate:{
                $toDate:'$dob.date'
            },
            age:"$dob.age",
            location:{
                type:'Point',
                coordinates:[
                    {
                        $convert:{
                            input: '$location.coordinates.longitude',
                            to:'double',
                            onError:0.0,
                            onNull:0.0
                        }
                    },
                    {
                        $convert:{
                            input: '$location.coordinates.latitude',
                            to:'double',
                            onError:0.0,
                            onNull:0.0
                        }
                    }
                   
                    
                ]
            }
        }
    },
    {
        $project:{
            gender:1,
            email:1,
            location:1,
            birthDate:1,
            age:1,
            fullName:{
                $concat:[
                    {$toUpper:{$substrCP:['$name.first',0,1]}},
                    {
                        $substrCP:[
                            '$name.first',1,
                            {
                                $subtract:[{$strLenCP:'$name.first'},1]
                            }
                        ]
                    },
                    " ",{$toUpper:{$substrCP:['$name.last',0,1]}},
                    {
                        $substrCP:[
                            '$name.last',1,
                            {
                                $subtract:[{$strLenCP:'$name.last'},1]
                            }
                        ]
                    }
                ]
            }
        }
    }
]
).pretty()

db.persons.aggregate([
    {
        $project:{
            _id:0,
            name:1,
            email:1,
            birthDate:{
                $toDate:'$dob.date'
            },
            age:"$dob.age",
            location:{
                type:'Point',
                coordinates:[
                    {
                        $convert:{
                            input: '$location.coordinates.longitude',
                            to:'double',
                            onError:0.0,
                            onNull:0.0
                        }
                    },
                    {
                        $convert:{
                            input: '$location.coordinates.latitude',
                            to:'double',
                            onError:0.0,
                            onNull:0.0
                        }
                    }
                   
                    
                ]
            }
        }
    },
    {
        $project:{
            gender:1,
            email:1,
            location:1,
            birthDate:1,
            age:1,
            fullName:{
                $concat:[
                    {$toUpper:{$substrCP:['$name.first',0,1]}},
                    {
                        $substrCP:[
                            '$name.first',1,
                            {
                                $subtract:[{$strLenCP:'$name.first'},1]
                            }
                        ]
                    },
                    " ",{$toUpper:{$substrCP:['$name.last',0,1]}},
                    {
                        $substrCP:[
                            '$name.last',1,
                            {
                                $subtract:[{$strLenCP:'$name.last'},1]
                            }
                        ]
                    }
                ]
            }
        }
    },
    {
        $group:{
            _id:{
                birthYear:{
                    $isoWeekYear:"$birthDate"
                }
            },numPersons:{
                $sum:1
            }
        }
    },
    {
        $sort:{numPersons:-1}
    }
]
).pretty()

//push array data into db
//use array-data.json

db.friends.insertMany([
    {
      "name": "Max",
      "hobbies": ["Sports", "Cooking"],
      "age": 29,
      "examScores": [
        { "difficulty": 4, "score": 57.9 },
        { "difficulty": 6, "score": 62.1 },
        { "difficulty": 3, "score": 88.5 }
      ]
    },
    {
      "name": "Manu",
      "hobbies": ["Eating", "Data Analytics"],
      "age": 30,
      "examScores": [
        { "difficulty": 7, "score": 52.1 },
        { "difficulty": 2, "score": 74.3 },
        { "difficulty": 5, "score": 53.1 }
      ]
    },
    {
      "name": "Maria",
      "hobbies": ["Cooking", "Skiing"],
      "age": 29,
      "examScores": [
        { "difficulty": 3, "score": 75.1 },
        { "difficulty": 8, "score": 44.2 },
        { "difficulty": 6, "score": 61.5 }
      ]
    }
  ])

db.friends.aggregate([
    {
        $group:{
            _id:{
                age:"$age"
            },
            allHobbies:{
                $push:"$hobbies"
            }
        }
    }
]).pretty()

//using unwind

db.friends.aggregate([
    {
        $unwind:"$hobbies"
    }
]).pretty()

db.friends.aggregate([
    {
        $unwind:"$hobbies"
    },{
        $group:{
            _id:{
                age:"$age"
            },
            allHobbies:{
                $push:"$hobbies"
            }
        }
    }
]).pretty()

//remove duplicates in output

db.friends.aggregate([
    {
        $unwind:"$hobbies"
    },{
        $group:{
            _id:{
                age:"$age"
            },
            allHobbies:{
                $addToSet:"$hobbies"
            }
        }
    }
]).pretty()

//using projection with arrays

db.friends.aggregate([
    {
        $project:{
            _id:0,
            examScore:{
                $slice:["$examScores",1]
            }
        }
    }
]).pretty()

db.friends.aggregate([
    {
        $project:{
            _id:0,
            examScore:{
                $slice:["$examScores",-1]
            }
        }
    }
]).pretty()

db.friends.aggregate([
    {
        $project:{
            _id:0,
            examScore:{
                $slice:["$examScores",1,3]
            }
        }
    }
]).pretty()

//to print size
db.friends.aggregate([
    {
        $project:{
            _id:0,
           numScores:{
                $size:["$examScores"]
            }
        }
    }
]).pretty()

db.friends.aggregate([
    {
        $project:{
            _id:0,
            scores:{
                $filter:{
                    input:'$examScores',
                    as:"sc",
                    cond:{
                        $gt:["$$sc.score",60]
                    }
                }
            }
        }
    }
]).pretty()


//apply multiple operations on array data
db.friends.aggregate([
    {
        $unwind:"$examScores"
    },{
        $sort:{
            examScores:-1
        }
    }
]).pretty()


db.friends.aggregate([
    {
        $unwind:"$examScores"
    },
    {
        $project:{
            _id:1,
            name:1,
            age:1,
            score:"$examScores.score"
        }
    },
    {
        $sort:{
            score:-1
        }
    },
    {
        $group:{
            _id:"$_id",
            name:{
                $first:"$name"
            },
            maxScore:{
                $max:"$score"
            }
        }
    },{
        $sort:{
            maxScore:-1
        }
    }
]).pretty()


//$bucket  ->grouping documents into bits and pieces

//db.persons.findOne()

db.persons.aggregate([
    {
        $bucket:{
            groupBy:"$dob.age",
            boundaries:[0,10,30,50,80,120],
            output:{
                numPersons:{
                    $sum:1
                },
                averageAge:{
                    $avg:"$dob.age"
                }
                
            }
        }
    }
])

db.persons.find({"dob.age":{$lt:10}})

db.persons.aggregate([
    {
        $bucket:{
            groupBy:"$dob.age",
            boundaries:[18,30,40,50,60,120],
            output:{
                numPersons:{
                    $sum:1
                },
                averageAge:{
                    $avg:"$dob.age"
                }
                
            }
        }
    }
])

db.persons.aggregate([
    {
        $bucketAuto:{
          
                groupBy:"$dob.age",
                buckets:5,
                output:{
                    numPersons:{
                        $sum:1
                    },
                    averageAge:{
                        $avg:"$dob.age"
                    }
                    
                }
            }
        }
])


//add more stages and write into collection

db.persons.aggregate([
    {
        $match:{
            gender:"male"
        }
        
    },
    {
        $project:{
            _id:0,gender:1,name:{$concat:["$name.first"," ","$name.last"]}
        ,birthDate:{
            $toDate:"$dob.date"
        }
    }
    },
    {
        $sort:{
            birthDate:1
        }
    },
    {
        $skip:10
    },
    {
        $limit:10
    },
    {
        $out:"transformedPersons"
    }
]).pretty()

//geoNear stage

//convert into geo object and insert into collection
//create index

db.transformedPersons.createIndex({location:"2dsphere"})

//no persons from this particular location ---(checkk no error)
db.transformedPersons.aggregate([
    {
        $geoNear:{
            near:{
                type:"Point",
                coordinates: [-18.4,-42.4]
            },
            maxDistance:1000000,
            num: 10,
            query: { age:{$gt:30}},
            distanceField:"distance"
        }
    }
]).pretty()