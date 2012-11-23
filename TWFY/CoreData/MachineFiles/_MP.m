// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MP.m instead.

#import "_MP.h"

const struct MPAttributes MPAttributes = {
	.entered_house = @"entered_house",
	.firstname = @"firstname",
	.image_height = @"image_height",
	.image_url = @"image_url",
	.image_width = @"image_width",
	.lastname = @"lastname",
	.member_id = @"member_id",
	.name = @"name",
	.person_id = @"person_id",
	.twfy_url = @"twfy_url",
};

const struct MPRelationships MPRelationships = {
	.constituency = @"constituency",
	.office = @"office",
	.party = @"party",
};

const struct MPFetchedProperties MPFetchedProperties = {
};

@implementation MPID
@end

@implementation _MP

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MP" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MP";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MP" inManagedObjectContext:moc_];
}

- (MPID*)objectID {
	return (MPID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"image_heightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"image_height"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"image_widthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"image_width"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"member_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"member_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"person_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"person_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic entered_house;






@dynamic firstname;






@dynamic image_height;



- (int16_t)image_heightValue {
	NSNumber *result = [self image_height];
	return [result shortValue];
}

- (void)setImage_heightValue:(int16_t)value_ {
	[self setImage_height:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveImage_heightValue {
	NSNumber *result = [self primitiveImage_height];
	return [result shortValue];
}

- (void)setPrimitiveImage_heightValue:(int16_t)value_ {
	[self setPrimitiveImage_height:[NSNumber numberWithShort:value_]];
}





@dynamic image_url;






@dynamic image_width;



- (int16_t)image_widthValue {
	NSNumber *result = [self image_width];
	return [result shortValue];
}

- (void)setImage_widthValue:(int16_t)value_ {
	[self setImage_width:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveImage_widthValue {
	NSNumber *result = [self primitiveImage_width];
	return [result shortValue];
}

- (void)setPrimitiveImage_widthValue:(int16_t)value_ {
	[self setPrimitiveImage_width:[NSNumber numberWithShort:value_]];
}





@dynamic lastname;






@dynamic member_id;



- (int32_t)member_idValue {
	NSNumber *result = [self member_id];
	return [result intValue];
}

- (void)setMember_idValue:(int32_t)value_ {
	[self setMember_id:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMember_idValue {
	NSNumber *result = [self primitiveMember_id];
	return [result intValue];
}

- (void)setPrimitiveMember_idValue:(int32_t)value_ {
	[self setPrimitiveMember_id:[NSNumber numberWithInt:value_]];
}





@dynamic name;






@dynamic person_id;



- (int32_t)person_idValue {
	NSNumber *result = [self person_id];
	return [result intValue];
}

- (void)setPerson_idValue:(int32_t)value_ {
	[self setPerson_id:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePerson_idValue {
	NSNumber *result = [self primitivePerson_id];
	return [result intValue];
}

- (void)setPrimitivePerson_idValue:(int32_t)value_ {
	[self setPrimitivePerson_id:[NSNumber numberWithInt:value_]];
}





@dynamic twfy_url;






@dynamic constituency;

	

@dynamic office;

	

@dynamic party;

	






@end
