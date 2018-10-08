unit MiddlewareChainImpl;

interface

uses
    MiddlewareIntf,
    MiddlewareChainIntf,
    RequestHandlerIntf,
    RequestIntf,
    ResponseIntf,
    MiddlewareCollectionIntf;

type
    {------------------------------------------------
     interface for any class having capability to
     manage one or more middlewares
     @author Zamrony P. Juhara <zamronypj@yahoo.com>
    -----------------------------------------------}
    TMiddlewareChain = class(TInterfacedObject, IMiddlewareChain)
    private
        middlewareList : IMiddlewareCollection;
        currentIndex : integer;
    public
        constructor create(const middlewares : IMiddlewareCollection);
        destructor destroy(); override;

        function handleChainedRequest(
            const request : IRequest;
            const response : IResponse;
            const middleware : IRequestHandler
        ) : IResponse;
        function next() : IRequestHandler;
    end;

implementation

    constructor TMiddlewareChain.create(const middlewares : IMiddlewareCollection);
    begin
        middlewareList := middlewares;
        currentIndex := 0;
    end;

    destructor TMiddlewareChain.destroy();
    begin
        inherited destroy();
        middlewareList := nil;
    end;

    function TMiddlewareChain.handleChainedRequest(
        const request : IRequest;
        const response : IResponse;
        const middleware : IRequestHandler
    ) : IResponse;
    var newResponse : IResponse;
    begin
        if (middleware <> nil) then
        begin
            newResponse := middleware.handleRequest(request, response);
            result := handleChainedRequest(request, newResponse, next());
        end else
        begin
            result := response;
        end;
    end;

    function TMiddlewareChain.next() : IRequestHandler;
    begin
        if (currentIndex < middlewareList.count() - 1) then
        begin
            inc(currentIndex);
            result := middlewareList.get(currentIndex);
        end else
        begin
            result := nil;
        end;
    end;

end.
