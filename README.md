# README

### Pre-requesites for the application to run:

- `ruby`-> `3.3.2`
- `rails`-> `7.1.3`

### Solution Approach:

Replacing `ApplicationRecord` inheritance from the models, As `ApplicationRecord` interacts with Persistent storage.
With `ApplicationMemory` which is a class that stores the records in a hashmap but it is only valid in the memory,
which is valotile and gets erased, The `Pet` model inherits from `ApplictionMemory` is built in a way that if we change
the inheritance to `ApplicationRecord` it will interact with the database without changing anything else.

### EndPoints

#### Allowed params

- `pet_type`:`['cat','dog']`
- `tracker_type`: `['small', 'medium', 'big']`
- `owner_id`:`Integer`
- `in_zone`:`[true,false]`
- `lost_tracker`: `[true,false]`

#### Pet Creation

```curl
    curl -X POST -H "Content-Type: application/json" -d '{
    "pet_type": "cat",
    "tracker_type": "big",
    "owner_id": 2,
    "in_zone": false,
"lost_tracker": true
}' http://localhost:3000/pets/
```
