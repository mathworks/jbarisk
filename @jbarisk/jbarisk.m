classdef jbarisk < handle
%JBARISK JBARisk connection.
%   C = JBARISK(TOKEN,TIMEOUT) creates a 
%   jbarisk connection object. TOKEN can 
%   be input as a string scalar or character vector.  TIMEOUT is the request value in 
%   seconds and input as a numeric value. The default value is 200 
%   seconds. C is a jbarisk object.
%
%   For example,
%   
%   c = jbarisk("mytoken")
%
%   returns
%
%   c = 
%   
%     jbarisk with properties:
%   
%            TimeOut: 200.00
%
%   See also CCSCENARIOS, COUNTRIES, FLOODDEPTHS, FLOODSCORES, PRICINGDATA, RISKTYPES, VULNERABILITYCURVEREGIONS.

%   Copyright 2023-2024 The MathWorks, Inc. 

  properties
    TimeOut
  end
  
  properties (Hidden = true)
    DebugModeValue
    HttpMethod
    MediaType
    URL   
  end
  
  properties (Access = 'private')
    Token 
  end
  
  methods (Access = 'public')
  
      function c = jbarisk(token,timeout,url,mediatype,debugmodevalue)
         
        %  Registered jbarisk users will have an authentication token
        if nargin < 1
          error("JBA Risk token required.");
        end
        
        % Store token
        c.Token = strcat("Basic ", token);

        % Set request timeout value
        if nargin < 2 || isempty(timeout)
          c.TimeOut = 200;
        else
          c.TimeOut = timeout;
        end

        % Create HTTP URL object
        if nargin < 3 || isempty(url)
          HttpURI = matlab.net.URI("https://api.jbarisk.com/");
        else
          HttpURI = matlab.net.URI(url);
        end
        c.URL = HttpURI.EncodedURI;
        
        % Specify HTTP media type i.e. application content to deal with
        if nargin < 4 || isempty(mediatype)
          HttpMediaType = matlab.net.http.MediaType("application/json");
        else
          HttpMediaType = matlab.net.http.MediaType(mediatype);
        end
        c.MediaType = string(HttpMediaType.MediaInfo);

        % Set http request debug value
        if nargin < 5 || isempty(debugmodevalue)
          c.DebugModeValue = 0;
        else
          c.DebugModeValue = debugmodevalue;
        end

        % Set default HttpMethod to "GET"
        c.HttpMethod = "GET";

        % Authorize token by checking for available databases
        tokenCheckResponse = countries(c);

        % Check output type
        if isa(tokenCheckResponse,"table") && any(strcmp(tokenCheckResponse.Properties.VariableNames,"message"))
          error(tokenCheckResponse.message)
        end

      end

      function [data,response] = makeRequest(c, endPointPath, jsonParams, varargin)
          %   [DATA,RESPONSE} = MAKEREQUEST(C,HTTPMETHOD,ENDPOINTURL,JSONPARAMS,VARARGIN)

          % Add API parameters if given
          for i = 1:2:length(varargin)
    
            if i == 1
              endPointPath = strcat(endPointPath,"?",string(varargin{i}),"=",string(varargin{i+1}));
            else
              endPointPath = strcat(endPointPath,"&",string(varargin{i}),"=",string(varargin{i+1}));
            end

          end
           
          % Encode endPointPath url
          endPointPath = matlab.internal.webservices.urlencode(endPointPath);

          % Create URI and set request properties
          HttpURI = matlab.net.URI(endPointPath);
          HttpHeader = matlab.net.http.HeaderField("Authorization",c.Token,"Content-Type",c.MediaType);
          RequestMethod = matlab.net.http.RequestMethod(upper(c.HttpMethod));

          % Set options
          options = matlab.net.http.HTTPOptions("ConnectTimeout",c.TimeOut, ...
                                      "DataTimeout",c.TimeOut, ...
                                      "Debug",c.DebugModeValue, ...
                                      "ResponseTimeout",c.TimeOut);

          % Create the request message
          switch lower(c.HttpMethod)

            case {'get','options'}
            
              Request = matlab.net.http.RequestMessage(RequestMethod,HttpHeader);
            
            case 'post'
            
              HttpBody = matlab.net.http.MessageBody();
              if isstruct(jsonParams)
                HttpBody.Payload = jsonencode(jsonParams);
              else
                HttpBody.Payload = jsonParams;
              end
              Request = matlab.net.http.RequestMessage(RequestMethod,HttpHeader,HttpBody);

          end

          % Send Request
          response = send(Request,HttpURI,options);
 
          % Return data from response
          try
            data = struct2table(response.Body.Data);
          catch
            data = response.Body.Data;
          end

      end
      
  end

end