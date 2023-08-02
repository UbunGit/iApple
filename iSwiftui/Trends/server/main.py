from fastapi import FastAPI
from fastapi.responses import JSONResponse
import uvicorn

from sql import datatype
from sql import unit
app = FastAPI()

from sql.unit import ReqFeach

@app.get("/feach")
async def api_feach(data:ReqFeach):
    data = unit.feach(name=data.name,predicate=data.predicate)
    return {"code":0, "data":data }


@app.get("/user/list")
async def api_datatype_select(predicate:str=None):
    data = datatype.select(predicate=predicate)
    return {"code":0, "data":data }

@app.post("/datatype/create")
async def api_datatypes_create(item:datatype.DataType):
    data = datatype.create(
        name=item.name,
        isSys=item.isSys,
        subTitle=item.subTitle
    )
    return {"code":0, "data":data } 


if __name__ == "__main__":

    uvicorn.run(app, host="0.0.0.0", port=8000)