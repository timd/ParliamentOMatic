// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Party.m instead.

#import "_Party.h"

const struct PartyAttributes PartyAttributes = {
	.name = @"name",
};

const struct PartyRelationships PartyRelationships = {
	.mps = @"mps",
};

const struct PartyFetchedProperties PartyFetchedProperties = {
};

@implementation PartyID
@end

@implementation _Party

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Party" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Party";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Party" inManagedObjectContext:moc_];
}

- (PartyID*)objectID {
	return (PartyID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic mps;

	
- (NSMutableSet*)mpsSet {
	[self willAccessValueForKey:@"mps"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"mps"];
  
	[self didAccessValueForKey:@"mps"];
	return result;
}
	






@end
