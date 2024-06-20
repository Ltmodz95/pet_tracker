# README

### Pre-requesites for the application to run:

- `ruby`-> `3.3.2`
- `rails`-> `7.1.3`

### Instalition:

Navigate to the project director and run the following commands

- `bundle install`
- `rails server`

### Testing

to run the test cases run:
`rspec`

### Solution Approach:

Replacing `ApplicationRecord` inheritance from the models, As `ApplicationRecord` interacts with Persistent storage.
With `ApplicationMemory` which is a class that stores the records in a hashmap but it is only valid in the memory,
which is valotile and gets erased, The `Pet` model inherits from `ApplictionMemory` is built in a way that if we change
the inheritance to `ApplicationRecord` it will interact with the database without changing anything else.

### EndPoints

#### Pet Creation:

**Params:**

- `pet_type`:`['cat','dog']`
- `tracker_type`: `['small', 'medium', 'big']`
- `owner_id`:`Integer`
- `in_zone`:`[true,false]`
- `lost_tracker`: `[true,false]`

```curl
curl -X POST -H "Content-Type: application/json" -d '{
    "pet_type": "cat",
    "tracker_type": "big",
    "owner_id": 2,
    "in_zone": false,
"lost_tracker": true
}' http://localhost:3000/pets/
```

#### Pets Retrival

```curl
curl -X GET http://localhost:3000/pets
```

#### Pet Querying

Params: `id`:`Integer`

```curl
curl -X GET http://localhost:3000/pets/:id
```

#### Pet Out of zone

```curl
curl -X GET http://localhost:3000/pets_out_of_zone
```
