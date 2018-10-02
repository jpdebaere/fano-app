unit HeaderIntf;

interface

type
    {------------------------------------------------
     interface for any class having capability to
     write HTTP header
     @author Zamrony P. Juhara <zamronypj@yahoo.com>
    -----------------------------------------------}
    IHeaderInterface = interface
        function writeHeader() : IHeaderInterface;
    end;

implementation
end.
