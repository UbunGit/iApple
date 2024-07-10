import random
import string
from . import datafield,datatype
from pydantic import BaseModel
class IRandom(BaseModel):
    type: str
    count: int

def randomTypes(type:str,length):
    print(type)
    result = []
    while length>0:
        data = randomType(type)
        result.append(data)
        length-=1
     
    return result
def randomType(type:str):
    
    predicate = " type= '{}' ".format(type)
    field = datafield.select(predicate=predicate)

    result = {}
    for item in field:

        key =  item["name"]
        typeStr =  item["type"]
        typeStr = item["valueType"]
        isarray = item["isArr"]
        typepredicate = " name= '{}' ".format(typeStr)
        typedata = datatype.select(predicate=typepredicate)[0]
        isSys = typedata["isSys"]
        if isarray==1:
            datas = randomTypes(typeStr,length=3)
            result[key] = datas
        else:
            if isSys != 1:
                data = randomType(typeStr)
                result[key] = data
            else:
                if typeStr == "string":
                    data = randomString(20)
                    result[key] = data
                if typeStr == "bool":
                    data = randomBool()
                    result[key] = data
                elif typeStr == "int":
                    data = randomInt()
                    result[key] = data
                elif typeStr == "image":
                    data = randomImage()
                    result[key] = data
                
    return result  


def randomString(length):
    characters = string.ascii_letters + string.digits
    random_string = ''.join(random.choices(characters, k=length))
    return random_string

def randomBool():
    return random.choice([True, False])

def randomInt(min=1,max=100):
    return random.randint(min, max)

def randomFloat(min=0,max=100):
    return random.uniform(min, max)

def randomImage(w=600,h=600):
    id =  randomInt()
    return "https://picsum.photos/{w}/{h}/id{id}"