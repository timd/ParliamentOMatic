// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Constituency.h instead.

#import <CoreData/CoreData.h>


extern const struct ConstituencyAttributes {
	__unsafe_unretained NSString *name;
} ConstituencyAttributes;

extern const struct ConstituencyRelationships {
	__unsafe_unretained NSString *mp;
} ConstituencyRelationships;

extern const struct ConstituencyFetchedProperties {
} ConstituencyFetchedProperties;

@class MP;



@interface ConstituencyID : NSManagedObjectID {}
@end

@interface _Constituency : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ConstituencyID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) MP *mp;

//- (BOOL)validateMp:(id*)value_ error:(NSError**)error_;





@end

@interface _Constituency (CoreDataGeneratedAccessors)

@end

@interface _Constituency (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (MP*)primitiveMp;
- (void)setPrimitiveMp:(MP*)value;


@end
