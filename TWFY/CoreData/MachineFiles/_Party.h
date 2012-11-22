// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Party.h instead.

#import <CoreData/CoreData.h>


extern const struct PartyAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *shortName;
} PartyAttributes;

extern const struct PartyRelationships {
	__unsafe_unretained NSString *mps;
} PartyRelationships;

extern const struct PartyFetchedProperties {
} PartyFetchedProperties;

@class MP;




@interface PartyID : NSManagedObjectID {}
@end

@interface _Party : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PartyID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* shortName;



//- (BOOL)validateShortName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *mps;

- (NSMutableSet*)mpsSet;





@end

@interface _Party (CoreDataGeneratedAccessors)

- (void)addMps:(NSSet*)value_;
- (void)removeMps:(NSSet*)value_;
- (void)addMpsObject:(MP*)value_;
- (void)removeMpsObject:(MP*)value_;

@end

@interface _Party (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveShortName;
- (void)setPrimitiveShortName:(NSString*)value;





- (NSMutableSet*)primitiveMps;
- (void)setPrimitiveMps:(NSMutableSet*)value;


@end
