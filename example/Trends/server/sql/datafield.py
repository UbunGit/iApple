from . import unit
from typing import Union
import json
import time
import sqlite3
from sqlite3 import Cursor
from pydantic import BaseModel


class DataField(BaseModel):
    type:str
    name:str
    valueType:str
    isArr: bool
    arrCount:Union[int, None] = 0
    subTitle:Union[str, None] = None

def create(data:DataField,user:str = "",zone = "defual"):
    sqlpath = (f"./{zone}.db")
    connect = sqlite3.connect(sqlpath)
    cursor = connect.cursor()
    now = int(time.time())
    sql = '''
    INSERT INTO field 
    (type, name,valueType,isArr,arrCount, subTitle,createtime,updatetime,createuser)
    VALUES 
    (?, ?, ?, ?, ?, ?, ?, ?);
    '''
    cursor.execute(sql, (data.type,data.name, data.valueType,data.isArr,data.subTitle,now,now,user))
    connect.commit()
    cursor.close()

def select(predicate:str = None, zone = "defual"):
    connect = sqlite3.connect(f'./{zone}.db')
    cursor = connect.cursor()
    sql = """
    select * from field 
    """
    if(predicate is not None):
        sql = sql + " where " + predicate
    cursor.execute(sql)
    json_data = unit.tojson(cursor)
    cursor.close()
    return json_data