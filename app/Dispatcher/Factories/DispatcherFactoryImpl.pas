unit DispatcherFactoryImpl;

interface

uses
    DispatcherFactoryIntf,
    DependencyIntf,
    DependencyContainerIntf,
    DependencyFactoryIntf,
    FactoryImpl;

type
    {------------------------------------------------
     interface for any class having capability to create
     dispatcher instance

     @author Zamrony P. Juhara <zamronypj@yahoo.com>
    -----------------------------------------------}
    TDispatcherFactory = class(TFactory, IDispatcherFactory, IDependencyFactory)
    public
        function build() : IDependency; override;
    end;

implementation

uses
    RouteMatcherIntf,
    MiddlewareCollectionAwareIntf,
    DispatcherImpl,
    RequestFactoryImpl,
    ResponseFactoryImpl,
    MiddlewareChainFactoryImpl;

    function TDispatcherFactory.build() : IDependency;
    var appMiddlewares : IMiddlewareCollectionAware;
    begin
        appMiddlewares := dependencyContainer.get('appMiddlewares') as IMiddlewareCollectionAware;

        result := TDispatcher.create(
            appMiddlewares.getBeforeMiddlewares(),
            appMiddlewares.getAfterMiddlewares(),
            TMiddlewareChainFactory.create(),
            dependencyContainer.get('router') as IRouteMatcher,
            TResponseFactory.create(dependencyContainer),
            TRequestFactory.create(dependencyContainer)
        );
    end;

end.