#!/usr/bin/python3
import psycopg2
import os
from dotenv import load_dotenv

class Database:
    def __init__(self):
        load_dotenv()
        self.db_info = {
        'host': os.getenv("DBHOST"),
        'dbname': os.getenv("DBNAME"),
        'user': os.getenv("DBUSER"),
        'password': os.getenv("DBPASSWORD"),
        'sslmode': 'prefer'
        }

    def db_connect(self):
        try:
            self.conn = psycopg2.connect(**self.db_info)
            self.conn.autocommit = True
            self.cursor = self.conn.cursor()
        except psycopg2.Error as e:
            print("Error:" + e)
        else:
            print("Database connect!")

    def db_close(self):
        try:
            self.conn.commit()
            self.cursor.close()
            self.conn.close()
        except psycopg2.OperationalError as e:
            print('Close Error!\n{0}').format(e)
        else:
            print('Database close!')

### CATEGORY ###
    def db_add_category(self, description: str):
        try:
            self.cursor.execute(
                "INSERT INTO category (description) VALUES (%s);", (description,)
            )
        except:
            self.conn.rollback()
            return False
        else:
            return True

    def db_get_all_category(self):
        try:
            self.cursor.execute(
                "SELECT * FROM category;"
            )
        except psycopg2.Error as e:
            #print(e)
            return None
        else:
            return self.cursor.fetchall()

    def db_get_categoryId_by_description(self, description: str):
        try:
            self.cursor.execute(
                "SELECT categoryid FROM category WHERE description = %s;", (description,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()

    def db_detele_category_by_categoryId(self, categoryId: int):
        if self.db_get_count_object_by_categoeyId(categoryId) == 0:
            try:
                self.cursor.execute(
                    "DELETE FROM category WHERE categoryid = %s;", (categoryId,)
                )
            except psycopg2.Error as e:
                #print(e)
                return -2
            else:
                return self.cursor.rowcount
        else:
            return -1
    
    def db_get_description_by_categoryId(self, categoryId: int):
        try:
            self.cursor.execute(
                "SELECT description FROM category WHERE categoryid = %s;", (categoryId,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()

### OBJECT ###
    '''
    objectInfo = {
        "desription": string
        "categoryId": integer
    }
    '''
    def db_add_object(self, objectInfo: dict):
        try:
            if "categoryId" in objectInfo.keys():
                self.cursor.execute(
                    "INSERT INTO object (categoryid, description) VALUES (%(categoryId)s, %(description)s);", (objectInfo)
                )
            else:
                self.cursor.execute(
                    "INSERT INTO object (description) VALUES (%(description)s);", (objectInfo)
                )                
        except:
            self.conn.rollback()
            return False
        else:
            return True

    def db_get_all_object(self):
        try:
            self.cursor.execute(
                "SELECT * FROM object;"
            )
        except:
            return None
        else:
            return self.cursor.fetchall()

    def db_get_object_by_categoryId(self, categoryId: int):
        try:
            self.cursor.execute(
                "SELECT * FROM object WHERE categoryId = %s;", (categoryId,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()
    
    '''
    return: 
        number of data been affect
        -2 psycopg2 error
        -1 foreign key reference error
    '''
    def db_delete_object_by_objectId(self, objectId: int):
        if self.db_get_count_location_by_objectId(objectId) == 0 and self.db_get_count_tag_by_objectId(objectId) == 0:
            try:
                self.cursor.execute(
                    "DELETE FROM object WHERE objectid = %s;", (objectId,)
                )
            except psycopg2.Error as e:
                #print(e)
                return -2
            else:
                return self.cursor.rowcount
        else:
            return -1

    def db_get_objectId_by_description(self, description: str):
        try:
            self.cursor.execute(
                "SELECT objectid, categoryid FROM object WHERE description = %s;", (description,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()

    def db_get_count_object_by_categoeyId(self, categoryId: int):
        try:
            self.cursor.execute(
                "SELECT COUNT(*) FROM object WHERE categoryid = %s;", (categoryId,)
            )
        except psycopg2.Error as e:
            #print(e)
            return -1
        else:
            return self.cursor.fetchall()[0][0]

    def db_get_object_by_objectId(self, objectId: int):
        try:
            self.cursor.execute(
                "SELECT * FROM object WHERE objectid = %s;", (objectId,)
            )
        except psycopg2.Error as e:
            #print(e)
            return None
        else:
            return self.cursor.fetchall()

    def db_get_object_by_description_fuzzy(self, description: str):
        try:
            self.cursor.execute(
                "SELECT * FROM object WHERE description ILIKE %s", ('%' + description + '%',)
            )
        except psycopg2.Error as e:
            print(e)
            return None
        else:
            return self.cursor.fetchall()

    '''
    given "object description" and "category description", search objectid in object table whose descriptions and categoryid are all equal. 
    '''
    def db_get_objectId_by_descriptions(self, _o_description: str, _c_description: str):
        try:
            self.cursor.execute(
                "SELECT objectid FROM object INNER JOIN category ON object.description = %s AND category.description = %s AND object.categoryid = category.categoryid;", (_o_description, _c_description,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()


### TAG ###
    '''
    tagInfo={
        "tagId": "string",
        "objectId": integer
        "description": "string"
    }
    '''
    def db_add_tag(self, tagInfo: dict):
        try:
            self.cursor.execute(
                "INSERT INTO tag (tagid, objectid, description) VALUES (%(tagId)s, %(objectId)s, %(description)s);", (tagInfo)
            )
        except psycopg2.Error as e:
            #print(e)
            self.conn.rollback()
            return False
        else:
            return True

    '''
    return -1: error
    '''
    def db_get_count_tag_by_objectId(self, objectId: str):
        try:
            self.cursor.execute(
                "SELECT COUNT(*) FROM tag WHERE objectid = %s;", (objectId,)
            )
        except psycopg2.Error as e:
            #print(e)
            return -1
        else:
            return self.cursor.fetchall()[0][0]

    def db_get_all_tag(self):
        try:
            self.cursor.execute(
                "SELECT * FROM tag;"
            )
        except:
            return None
        else:
            return self.cursor.fetchall()
    
    def db_get_count_tag_by_objectId(self, objectId: int):
        try:
            self.cursor.execute(
                "SELECT COUNT(*) FROM tag WHERE objectId = %s;", (objectId,)
            )
        except:
            return 0
        else:
            return self.cursor.fetchall()[0][0]

    def db_get_tags_by_objectId(self, objectId: int):
        try:
            self.cursor.execute(
                "SELECT * FROM tag WHERE objectid = %s;", (objectId,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()

    def db_get_tag_by_tagId(self, tagId: str):
        try:
            self.cursor.execute(
                "SELECT * FROM tag WHERE tagid = %s;", (tagId,)
            )
        except psycopg2.Error as e:
            #print(e)
            return None
        else:
            return self.cursor.fetchall()

    def db_get_objectId_by_tagId(self, tagId: str):
        try:
            self.cursor.execute(
                "SELECT objectid FROM tag WHERE tagid = %s;", (tagId,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()

    def db_get_tagId_by_tagIndex(self, tagIndex: int):
        try:
            self.cursor.execute(
                "SELECT tagid FROM tag WHERE tagindex = %s;", (tagIndex,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()
    
    def db_get_tagIndex_by_tagId(self, tagId: int):
        try:
            self.cursor.execute(
                "SELECT tagindex FROM tag WHERE tagid = %s;", (tagId,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()

    def db_get_tagIndex_by_objectId(self, objectId: int):
        try:
            self.cursor.execute(
                "SELECT tagindex FROM tag WHERE objectid = %s;", (objectId,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()

    def db_get_objectId_by_tagIndex(self, tagIndex: int):
        try:
            self.cursor.execute(
                "SELECT objectid FROM tag WHERE tagindex = %s;", (tagIndex,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()
    
    '''
    Warning:
    When executing "update object tag" operation, be sure deleting relational data in location table first before this function called.
    
    return numbers of data is been affected
        -1: foreign key reference error
        -2: psycopg2 error
    '''
    def db_update_objectId_by_tagIndex(self, tagIndex: int, objectId: int):
        _t_index = self.db_get_tagId_by_tagIndex(tagIndex)
        if _t_index is not None and _t_index[0][0] is not None and self.db_get_count_detection_by_tagId(_t_index[0][0]) == 0:
            try:
                self.cursor.execute(
                    "UPDATE tag SET objectid = %s WHERE tagindex = %s;", (objectId, tagIndex,)
                )
            except psycopg2.Error as e:
                print(e)
                return -2
            else:
                return self.cursor.rowcount
        else:
            return -1


### LOCATION ###
    '''
    locationInfo = {
        "objectId": integer,
        "areaId": integer,
        "time": date_datetime.strftime("%Y-%m-%d %H:%M:%S+00"),
        "direction": integer
    }
    '''
    def db_add_location(self, locationInfo: dict):
        try:
            self.cursor.execute(
                "INSERT INTO location (objectid, areaid, time, direction) VALUES (%(objectId)s, %(areaId)s, %(time)s, %(direction)s);", (locationInfo)
            )
        except psycopg2.Error as e:
            #print(e)
            self.conn.rollback()
            return False
        else:
            return True
    
    def db_get_count_location_by_objectId(self, objectId: int):
        try:
            self.cursor.execute(
                "SELECT COUNT(*) FROM location WHERE objectid = %s;", (objectId,)
            )
        except:
            return 0
        else:
            return self.cursor.fetchall()[0][0]

    def db_get_location_by_objectId(self, objectId: int):
        try:
            self.cursor.execute(
                "SELECT * FROM location WHERE objectId = %s;", (objectId,)
            )
        except:
            return None
        else:
            return self.cursor.fetchall()

    def db_get_latest_location_by_objectId(self, objectId: int, latest: int = 10):
        try:
            self.cursor.execute(
                "SELECT * FROM location WHERE objectid = %s ORDER BY time DESC LIMIT %s;", (objectId, latest)
            )
        except psycopg2.Error as e:
            print(e)
            return None
        else:
            return self.cursor.fetchall()

    def db_get_tag_in_location_by_areaId(self, areaId: int, latest: int = 10):
        try:
            self.cursor.execute(
                "SELECT objectid, time FROM (SELECT objectid, time, row_number() OVER (PARTITION BY tagid ORDER BY time DESC) AS seqnum FROM location WHERE areaid = %s)t WHERE seqnum <= %s",
                (areaId, latest)
                #"SELECT objectid, time FROM location WHERE areaid = %s GROUP BY objectid, time ORDER BY time DESC LIMIT %s;", (areaId, latest)
            )
        except psycopg2.Error as e:
            print(e)
            return
        else:
            return self.cursor.fetchall()

    def db_delete_location_by_objectId(self, objectId: int):
        try:
            self.cursor.execute(
                "DELETE FROM location WHERE objectid = %s;", (objectId,)
            )
        except psycopg2.Error as e:
            #print(e)
            return -1
        else:
            return self.cursor.rowcount

### DETECTION ###
    def db_delete_detection_by_tagId(self, tagId: str):
        try:
            self.cursor.execute(
                "DELETE FROM detection WHERE tagid = %s;", (tagId,)
            )
        except psycopg2.Error as e:
            #print(e)
            return -1
        else:
            return self.cursor.rowcount
    
    def db_get_count_detection_by_tagId(self, tagId: str):
        try:
            self.cursor.execute(
                "SELECT COUNT(*) FROM detection WHERE tagId = %s;", (tagId,)
            )
        except:
            return -1
        else:
            return self.cursor.fetchall()[0][0]
    
    def db_get_latest_number_detection(self, latest: int):
        try:
            self.cursor.execute(
                "SELECT * FROM detection ORDER BY time DESC LIMIT %s;", (latest,)
            )
        except psycopg2.Error as e:
            #print(e)
            return None
        else:
            return self.cursor.fetchall()     

    def db_get_latest_number_detection_by_tagId(self, tagId: str, latest: int = 10):
        try:
            self.cursor.execute(
                "SELECT tagid, antid, time FROM (SELECT tagid, antid, time, row_number() OVER (PARTITION BY antid ORDER BY time DESC) AS seqnum FROM detection WHERE tagid = %s)t WHERE seqnum <= %s;",
                (tagId, latest, )
            )
        except psycopg2.Error as e:
            #print(e)
            return None
        else:
            return self.cursor.fetchall()

    def db_get_tagId_in_location_by_areaId(self, areaId: int):
        try:
            self.cursor.execute(
                "SELECT tagid, time FROM location WHERE areaId = %s::INTEGER;", (areaId, )
            )
        except psycopg2.OperationalError as e:
            #print('Unable to connect!\n{0}').format(e)
            return
        else:
            return self.cursor.fetchall()

    def db_get_antId_in_detection_by_tagId(self, tagId: str, limit: int = 10):
        try:
            self.cursor.execute(
                "SELECT antid, MAX(time) FROM (SELECT * FROM detection WHERE tagid = %s ORDER BY time DESC LIMIT %s) AS d GROUP BY antid;", (tagId, limit)
                #"SELECT DISTINCT antid, time FROM detection WHERE tagid = %s ORDER BY time DESC LIMIT %s;", (tagId, limit)
                #"SELECT DISTINCT antid FROM (SELECT * FROM detection WHERE tagId = %s ORDER BY time DESC limit %s)t;", (limit, tagId)
            )
        except psycopg2.Error as e:
            #print(e)
            return None
        else:
            return self.cursor.fetchall()
