//
//  CDTodo.m
//  TO-DO
//
//  Created by Siegrain on 16/6/2.
//  Copyright © 2016年 com.siegrain. All rights reserved.
//

#import "CDTodo.h"
#import "LCTodo.h"

@implementation CDTodo
@synthesize photoImage = _photoImage;
@synthesize cellHeight = _cellHeight;
@synthesize lastDeadline = _lastDeadline;
@synthesize isReordering = _isReordering;

#pragma mark - accessors
- (UIImage*)avatarPhoto
{
    if (!_photoImage) {
        _photoImage = [UIImage imageWithData:self.photoData];
    }
    return _photoImage;
}

+ (NSString*)MR_entityName
{
    return @"Todo";
}
#pragma mark - convert LCTodo to CDTodo
+ (instancetype)cdTodoWithLCTodo:(LCTodo*)lcTodo inContext:(NSManagedObjectContext*)context
{
    /*
	 Mark: MagicalRecord
	 新实体必须在当前线程的上下文创建，否则会出现“Cocoa error: 133000”
	 */
    CDTodo* cdTodo = [CDTodo MR_createEntityInContext:context];
    cdTodo.user = [CDUser userWithLCUser:lcTodo.user inContext:context];
    cdTodo.objectId = lcTodo.objectId;
    [cdTodo cdTodoReplaceByLCTodo:lcTodo];

    return cdTodo;
}
- (instancetype)cdTodoReplaceByLCTodo:(LCTodo*)lcTodo
{
    self.status = @(lcTodo.status);
    self.isHidden = @(lcTodo.isHidden);
    self.isCompleted = @(lcTodo.isCompleted);
    self.photo = lcTodo.photo;
    self.createdAt = lcTodo.localCreatedAt;
    self.updatedAt = lcTodo.localUpdatedAt;
    self.syncVersion = @(lcTodo.syncVersion);
    self.title = lcTodo.title;
    self.sgDescription = lcTodo.sgDescription;
    self.deadline = lcTodo.deadline;
    self.location = lcTodo.location;

    return self;
}
@end