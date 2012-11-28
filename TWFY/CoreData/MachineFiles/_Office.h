// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Office.h instead.

#import <CoreData/CoreData.h>


extern const struct OfficeAttributes {
	__unsafe_unretained NSString *dept;
	__unsafe_unretained NSString *from_date;
	__unsafe_unretained NSString *position;
	__unsafe_unretained NSString *to_date;
} OfficeAttributes;

extern const struct OfficeRelationships {
	__unsafe_unretained NSString *mp;
} OfficeRelationships;

extern const struct OfficeFetchedProperties {
} OfficeFetchedProperties;

@class MP;






@interface OfficeID : NSManagedObjectID {}
@end

@interface _Office : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (OfficeID*)objectID;





@property (nonatomic, strong) NSString* dept;



//- (BOOL)validateDept:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* from_date;



//- (BOOL)validateFrom_date:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* position;



//- (BOOL)validatePosition:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* to_date;



//- (BOOL)validateTo_date:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) MP *mp;

//- (BOOL)validateMp:(id*)value_ error:(NSError**)error_;





@end

@interface _Office (CoreDataGeneratedAccessors)

@end

@interface _Office (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDept;
- (void)setPrimitiveDept:(NSString*)value;




- (NSString*)primitiveFrom_date;
- (void)setPrimitiveFrom_date:(NSString*)value;




- (NSString*)primitivePosition;
- (void)setPrimitivePosition:(NSString*)value;




- (NSString*)primitiveTo_date;
- (void)setPrimitiveTo_date:(NSString*)value;





- (MP*)primitiveMp;
- (void)setPrimitiveMp:(MP*)value;


@end
