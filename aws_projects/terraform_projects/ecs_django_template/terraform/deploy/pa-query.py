import boto3

from ssm_parameter_store import SSMParameterStore

store = SSMParameterStore(prefix='/Prod')

# access a parameter under /Prod/ApiSecret
my_secret = store['ApiSecret']

# check if a parameter available in the store
'<key here>' in store

# list available parameters
print store.keys()

# access parameter under DB prefix
db_store = store['DB']

# this will query /Prod/DB/Password
db_password = store['DB']['Password']

# create a store that caches the results up to 10sec.
store = SSMParameterStore(ttl=10)