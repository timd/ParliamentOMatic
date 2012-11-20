// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MP.h instead.

#import <CoreData/CoreData.h>


extern const struct MPAttributes {
	__unsafe_unretained NSString *member_id;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *person_id;
} MPAttributes;

extern const struct MPRelationships {
	__unsafe_unretained NSString *constituency;
	__unsafe_unretained NSString *party;
} MPRelationships;

extern const struct MPFetchedProperties {
} MPFetchedProperties;

@class Constituency;
@class Party;





@interface MPID : NSManagedObjectID {}
@end

@interface _MP : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MPID*)objectID;





@property (nonatomic, strong) NSNumber* member_id;



@property int32_t member_idValue;
- (int32_t)member_idValue;
- (void)setMember_idValue:(int32_t)value_;

//- (BOOL)validateMember_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* person_id;



@property int32_t person_idValue;
- (int32_t)person_idValue;
- (void)setPerson_idValue:(int32_t)value_;

//- (BOOL)validatePerson_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Constituency *constituency;

//- (BOOL)validateConstituency:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Party *party;

//- (BOOL)validateParty:(id*)value_ error:(NSError**)error_;





@end

@interface _MP (CoreDataGeneratedAccessors)

@end

@interface _MP (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveMember_id;
- (void)setPrimitiveMember_id:(NSNumber*)value;

- (int32_t)primitiveMember_idValue;
- (void)setPrimitiveMember_idValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitivePerson_id;
- (void)setPrimitivePerson_id:(NSNumber*)value;

- (int32_t)primitivePerson_idValue;
- (void)setPrimitivePerson_idValue:(int32_t)value_;





- (Constituency*)primitiveConstituency;
- (void)setPrimitiveConstituency:(Constituency*)value;



- (Party*)primitiveParty;
- (void)setPrimitiveParty:(Party*)value;


@end
