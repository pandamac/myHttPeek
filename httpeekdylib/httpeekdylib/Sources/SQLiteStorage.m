#import "SQLiteStorage.h"
#include <sqlite3.h>

extern int WRITE_GLOBAL_COUNT;

@implementation SQLiteStorage

// Database settings
static BOOL logToConsole = TRUE;

static NSString *MyDBFileFormat = @"/var/root/tmp/filemon-%@-%@.db";

static const char createTableStmtStr[] = "CREATE TABLE FileMon (CountRank TEXT,Behavior TEXT, className_methodName TEXT, argumentsAndReturnValueDict TEXT)";
static const char saveFileMonTracerStmtStr[] = "INSERT INTO FileMon VALUES (?1, ?2, ?3, ?4)";


// Internal stuff
static sqlite3_stmt *saveFileMonTracerStmt;
static sqlite3 *dbConnection;

+(NSString *)getBackgroundRealDateString
{
    NSDate *date = [NSDate date];
    date = [date dateByAddingTimeInterval:8*3600]; //东八区
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; //北京时间
    NSString *datestr =  [dateFormatter stringFromDate:date];
    NSString *ret = [NSString stringWithString:datestr];
    [dateFormatter release];
    return ret;
}

//- (SQLiteStorage *)initWithDefaultDBFilePathAndLogToConsole: (BOOL) shouldLog {
//    NSString *DBFilePath = nil;
//    // Put application name in the DB's filename to avoid confusion
//    NSString *appId = [[NSBundle mainBundle] bundleIdentifier];
//    
//    NSString *time = [SQLiteStorage getBackgroundRealDateString];
//    
//    DBFilePath =[NSString stringWithFormat:MyDBFileFormat, time,appId];
//    NSLog(@"DBFilePath = %@",DBFilePath);
//    return [self initWithDBFilePath: [DBFilePath stringByExpandingTildeInPath] andLogToConsole: shouldLog];
//}
//
//
//- (SQLiteStorage *)initWithDBFilePath:(NSString *) DBFilePath andLogToConsole: (BOOL) shouldLog {
//    self = [super init];
//    sqlite3 *dbConn;
//
//    // Open the DB file if it's already there
//    if (sqlite3_open_v2([DBFilePath UTF8String], &dbConn, SQLITE_OPEN_READWRITE, NULL) != SQLITE_OK) {
//
//	// If not, create the DB file
//        NSLog(@"DBFilePath = %@",DBFilePath);
//	if (sqlite3_open_v2([DBFilePath UTF8String], &dbConn, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL) != SQLITE_OK) {
//       	 	NSLog(@"FileMonSQLiteStorage - Unable to open database!");
//       		return nil;
//    	}
//	else {
//    		// Create the tables in the DB we just created
//    		if (sqlite3_exec(dbConn, createTableStmtStr, NULL, NULL, NULL) != SQLITE_OK) {
//			NSLog(@"FileMonSQLiteStorage - Unable to create tables!");
//			return nil;
//    		}
//        else
//            NSLog(@"FileMonSQLiteStorage - create tables!");
//    	}
//    }
//
//    // Prepare the INSERT statement we'll use to store everything
//    sqlite3_stmt *statement = nil;
//    if (sqlite3_prepare_v2(dbConn, saveFileMonTracerStmtStr, -1, &statement, NULL) != SQLITE_OK) {
//        NSLog(@"FileMonSQLiteStorage - Unable to prepare statement!");
//        return nil;
//    }
//
//    saveFileMonTracerStmt = statement;
//    dbConnection = dbConn;
//    logToConsole = shouldLog;
//    return self;
//}
//
//
//- (BOOL)saveFileMonTracer: (FileMonTracer*) FileMonTracer {
//    int queryResult = SQLITE_ERROR;
//
//// Serialize arguments and return value to an XML plist
////    NSData *argsAndReturnValueData = [FileMonTracer serializeArgsAndReturnValue];
////    if (argsAndReturnValueData == nil) {
////        NSLog(@"FileMonSQLiteStorage::saveTraceCall: can't serialize args or return value");
////        return NO;
////    }
////    NSString *argsAndReturnValueStr = [[NSString alloc] initWithData:argsAndReturnValueData encoding:NSUTF8StringEncoding];
//
//    NSString *argsAndReturnValueStr =[NSString stringWithFormat:@"%@",[FileMonTracer argsAndReturnValue]];
//    
//    // Do the query; has to be atomic or we get random SQLITE_PROTOCOL errors
//    // TODO: this is probably super slow
//
////Objective-C支持程序中的多线程。这就意味着两个线程有可能同时修改同一个对象，这将在程序中导致严重的问题。
////为了避免这种多个线程同时执行同一段代码的情况，Objective-C提供了@synchronized()指令。
////指令@synchronized()通过对一段代码的使用进行加锁。其他试图执行该段代码的线程都会被阻塞，直到加锁线程退出执行该段被保护的代码段，
////也就是说@synchronized()代码块中的最后一条语句已经被执行完毕的时候。
//    
//    @synchronized(MyDBFileFormat) {
//    	sqlite3_reset(saveFileMonTracerStmt);
//        char chRank[10];
//        sprintf(chRank, "%d",WRITE_GLOBAL_COUNT);
//        sqlite3_bind_text(saveFileMonTracerStmt, 1, chRank, -1, nil);
//    	sqlite3_bind_text(saveFileMonTracerStmt, 2, [ [FileMonTracer Behavior] UTF8String], -1, nil);
//    	sqlite3_bind_text(saveFileMonTracerStmt, 3, [ [FileMonTracer className_methodName] UTF8String], -1, nil);
//    	sqlite3_bind_text(saveFileMonTracerStmt, 4, [argsAndReturnValueStr UTF8String], -1, nil);
//        queryResult = sqlite3_step(saveFileMonTracerStmt);
//        if (logToConsole) {
//            NSLog(@"\n-----FileMon-----%d \nCALLED %@ %@\nWITH:\n%@\n---------------",\
//                  WRITE_GLOBAL_COUNT, [FileMonTracer Behavior], [FileMonTracer className_methodName], [FileMonTracer argsAndReturnValue]);
//        }
//        WRITE_GLOBAL_COUNT++;
//    }
//    [argsAndReturnValueStr release];
//
//    if (queryResult != SQLITE_DONE) {
//        NSLog(@"FileMonSQLiteStorage - Commit Failed: %x!", queryResult);
//    	return NO;
//    }
//    return YES;
//}
//
//- (void)dealloc
//{
//    NSLog(@"dealloc~~~~~~~~");
//    sqlite3_finalize(saveFileMonTracerStmt);
//    sqlite3_close(dbConnection);
//    [super dealloc];
//}
//
@end


