#import "FileMonTracer.h"

@interface SQLiteStorage : NSObject {

}

- (SQLiteStorage *)initWithDefaultDBFilePathAndLogToConsole: (BOOL) shouldLog;
- (SQLiteStorage *)initWithDBFilePath:(NSString *) DBFilePath andLogToConsole: (BOOL) shouldLog;
- (BOOL)saveFileMonTracer: (FileMonTracer*) tracedCall;


@end

