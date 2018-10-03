unit RouteListImpl;

interface

uses
    RouteListIntf,
    HashListImpl;

type
    {------------------------------------------------
     interface for any class having capability to
     handler route
     @author Zamrony P. Juhara <zamronypj@yahoo.com>
    -----------------------------------------------}
    TRouteList = class(THashList, IRouteList)
    end;

implementation
end.
