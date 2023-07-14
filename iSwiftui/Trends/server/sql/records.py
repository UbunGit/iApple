import json
import time
import sqlite3
from sqlite3 import Cursor
from . import unit
from pydantic import BaseModel

class Record(BaseModel):
    type: str
    fields: str

def select(predicate:str = None, zone = "defual"):
   
    connect = sqlite3.connect(f'./{zone}.db')
    cursor = connect.cursor()
    sql = """
    select * from records 
    """
    if(predicate is not None):
        sql = sql + " where " + predicate
    cursor.execute(sql)
    json_data = unit.tojson(cursor)
    cursor.close()
    return json_data

def create(data:Record,user="0",zone = "defual"):
    sqlpath = (f"./{zone}.db")
    connect = sqlite3.connect(sqlpath)
    cursor = connect.cursor()
    now = int(time.time())
    sql = '''
    INSERT INTO records 
    (type, fields, createtime,updatetime,createuser)
    VALUES 
    (?, ?, ?, ?, ?);
    '''
    cursor.execute(sql, (data.type, data.fields,now,now,user))
    connect.commit()
    cursor.close()

def groupTypes(zone = "defual"):
    connect = sqlite3.connect(f'./{zone}.db')
    cursor = connect.cursor()
    sql = '''
    select type from records group by type
    '''
    cursor.execute(sql)
    json_data = unit.tojson(cursor)
    cursor.close()
    return json_data


# inster(type="test",fields="ddddd")
# results = records(type="test")
# types = groupTypes()
# print(types)