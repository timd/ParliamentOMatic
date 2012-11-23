// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MP.h instead.

#import <CoreData/CoreData.h>


extern const struct MPAttributes {
	__unsafe_unretained NSString *entered_house;
	__unsafe_unretained NSString *firstname;
	__unsafe_unretained NSString *image_height;
	__unsafe_unretained NSString *image_url;
	__unsafe_unretained NSString *image_width;
	__unsafe_unretained NSString *lastname;
	__unsafe_unretained NSString *member_id;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *person_id;
	__unsafe_unretained NSString *twfy_url;
} MPAttributes;

extern const struct MPRelationships {
	__unsafe_unretained NSString *constituency;
	__unsafe_unretained NSString *office;
	__unsafe_unretained NSString *party;
} MPRelationships;

extern const struct MPFetchedProperties {
} MPFetchedProperties;

@class Constituency;
@class Office;
@class Party;












@interface MPID : NSManagedObjectID {}
@end

@interface _MP : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MPID*)objectID;





@property (nonatomic, strong) NSString* entered_house;



//- (BOOL)validateEntered_house:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* firstname;



//- (BOOL)validateFirstname:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* image_height;



@property int16_t image_heightValue;
- (int16_t)image_heightValue;
- (void)setImage_heightValue:(int16_t)value_;

//- (BOOL)validateImage_height:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* image_url;



//- (BOOL)validateImage_url:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* image_width;



@property int16_t image_widthValue;
- (int16_t)image_widthValue;
- (void)setImage_widthValue:(int16_t)value_;

//- (BOOL)validateImage_width:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastname;



//- (BOOL)validateLastname:(id*)value_ error:(NSError**)error_;





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





@property (nonatomic, strong) NSString* twfy_url;



//- (BOOL)validateTwfy_url:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Constituency *constituency;

//- (BOOL)validateConstituency:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Office *office;

//- (BOOL)validateOffice:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Party *party;

//- (BOOL)validateParty:(id*)value_ error:(NSError**)error_;





@end

@interface _MP (CoreDataGeneratedAccessors)

@end

@interface _MP (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEntered_house;
- (void)setPrimitiveEntered_house:(NSString*)value;




- (NSString*)primitiveFirstname;
- (void)setPrimitiveFirstname:(NSString*)value;




- (NSNumber*)primitiveImage_height;
- (void)setPrimitiveImage_height:(NSNumber*)value;

- (int16_t)primitiveImage_heightValue;
- (void)setPrimitiveImage_heightValue:(int16_t)value_;




- (NSString*)primitiveImage_url;
- (void)setPrimitiveImage_url:(NSString*)value;




- (NSNumber*)primitiveImage_width;
- (void)setPrimitiveImage_width:(NSNumber*)value;

- (int16_t)primitiveImage_widthValue;
- (void)setPrimitiveImage_widthValue:(int16_t)value_;




- (NSString*)primitiveLastname;
- (void)setPrimitiveLastname:(NSString*)value;




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




- (NSString*)primitiveTwfy_url;
- (void)setPrimitiveTwfy_url:(NSString*)value;





- (Constituency*)primitiveConstituency;
- (void)setPrimitiveConstituency:(Constituency*)value;



- (Office*)primitiveOffice;
- (void)setPrimitiveOffice:(Office*)value;



- (Party*)primitiveParty;
- (void)setPrimitiveParty:(Party*)value;


@end
