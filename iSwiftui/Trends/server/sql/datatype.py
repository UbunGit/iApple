from . import unit
from typing import Union
import json
import time
import sqlite3
from sqlite3 import Cursor
from pydantic import BaseModel


class DataType(BaseModel):
    name: str
    isSys: bool
    subTitle:Union[str, None] = None

def create(name: str,isSys:bool,subTitle:str='',user:str = "",zone = "defual"):
    sqlpath = (f"./{zone}.db")
    connect = sqlite3.connect(sqlpath)
    cursor = connect.cursor()
    now = int(time.time())
    issys = int(isSys == False)
    sql = '''
    INSERT INTO datatype 
    (name, isSys,subTitle,createtime,updatetime,createuser)
    VALUES 
    (?, ?, ?, ?, ?, ?);
    '''
    cursor.execute(sql, (name, issys,subTitle,now,now,user))
    connect.commit()
    cursor.close()

def update(name: str,isSys:bool,subTitle:str='',user:str = "",zone = "defual"):
    sqlpath = (f"./{zone}.db")
    connect = sqlite3.connect(sqlpath)
    cursor = connect.cursor()
    now = int(time.time())
    issys = int(isSys == False)
    sql = '''
    UPDATE datatype SET
    isSys=?,subTitle=?,updatetime=?,createuser=?
    WHERE name=?;
    '''
    cursor.execute(sql, ( issys,subTitle,now,user,name))
    connect.commit()
    cursor.close()

def select(predicate:str = None ,zone = "defual"):

    connect = sqlite3.connect(f'./{zone}.db')
    cursor = connect.cursor()
    sql = """
    select * from datatype 
    """
    if(predicate is not None):
        sql = sql + " where " + predicate
    cursor.execute(sql)
    json_data = unit.tojson(cursor)
    cursor.close()
    return json_data

