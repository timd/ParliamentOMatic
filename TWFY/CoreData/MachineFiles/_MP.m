// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MP.m instead.

#import "_MP.h"

const struct MPAttributes MPAttributes = {
	.member_id = @"member_id",
	.name = @"name",
	.person_id = @"person_id",
};

const struct MPRelationships MPRelationships = {
	.constituency = @"constituency",
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




@dynamic member_id;



- (int16_t)member_idValue {
	NSNumber *result = [self member_id];
	return [result shortValue];
}

- (void)setMember_idValue:(int16_t)value_ {
	[self setMember_id:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveMember_idValue {
	NSNumber *result = [self primitiveMember_id];
	return [result shortValue];
}

- (void)setPrimitiveMember_idValue:(int16_t)value_ {
	[self setPrimitiveMember_id:[NSNumber numberWithShort:value_]];
}





@dynamic name;






@dynamic person_id;



- (int16_t)person_idValue {
	NSNumber *result = [self person_id];
	return [result shortValue];
}

- (void)setPerson_idValue:(int16_t)value_ {
	[self setPerson_id:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePerson_idValue {
	NSNumber *result = [self primitivePerson_id];
	return [result shortValue];
}

- (void)setPrimitivePerson_idValue:(int16_t)value_ {
	[self setPrimitivePerson_id:[NSNumber numberWithShort:value_]];
}





@dynamic constituency;

	

@dynamic party;

	






@end
