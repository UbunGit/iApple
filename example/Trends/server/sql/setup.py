import sqlite3

sqlite = sqlite3.connect('./defual.db')
cursor = sqlite.cursor()

def createDataType():
    records = """
CREATE TABLE "member" (
	"uuid"	INTEGER NOT NULL UNIQUE,
	"nickName"	TEXT,
	"avatar"	TEXT,
	"isBlue"	INTEGER,
	PRIMARY KEY("uuid" AUTOINCREMENT)
);
    """
    cursor.execute(records)

createDataType()
sqlite.commit()
sqlite.close()    