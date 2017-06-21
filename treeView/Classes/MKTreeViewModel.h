//
//  Model.h
//  treeView
//
//  Created by Mike on 16/7/20.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKTreeViewModel : NSObject

@property (nonatomic, strong) NSArray *childModelArray;
@property (nonatomic, assign) NSUInteger level;
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, assign) BOOL isChecked;

+ (instancetype)modelAtRow:(NSUInteger)row inArray:(NSArray *)dataArray;

+ (NSUInteger)rowCountForModelArray:(NSArray *)modelArray;

- (void)setCheckFatherInModelArray:(NSArray *)dataArray;
- (void)setCheckChild;

- (void)allExpandedChildCount:(NSUInteger *)count;

@end
