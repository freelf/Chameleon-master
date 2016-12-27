#import "LPMessage.h"

@implementation LPMessage

- (id)init{
	self = [super init];
	if(self != nil){
		data = NULL;
		
		type = 0;
		command = 0;
		linkid = 0;
		modeid = 0;
	}
	return self;
}

-(void) setType : (short) _type
{
    type = _type;
}

-(short) getType
{
    return type;
}

-(void) setCommand : (short) _command
{
    command = _command;
}

-(short) getCommand
{
    return command;
}

-(void) setData : (NSData*) _data
{
    data = _data;
}

-(NSData*) getData
{
    return data;
}

-(long) getLinkid
{
    return linkid;
}

-(void) setLinkid : (long) _linkid
{
    linkid = _linkid;
}

-(long) getModeid
{
    return modeid;
}

-(void) setModeid : (long) _modeid
{
    modeid = _modeid;
}

-(void) setPlayerid:(int) _playerid
{
	playerid = _playerid;
}

-(int) getPlayerid
{
	return playerid;
}

-(NSString*) getAdid
{
	return Adid;
}

-(void) setAdid : (NSString*) _adid
{
	Adid = [_adid copy];
}
@end

