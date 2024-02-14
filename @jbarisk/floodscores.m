function [data, response] = floodscores(c,id,scenario,varargin)
%FLOODSCORES JBARisk flood score information.
%   [DATA,RESPONSE] = FLOODSCORES(C,COUNTRYID) returns flood score information for a specific
%   country.  COUNTRYID is input as a scalar string or character vector.
%
%   [DATA,RESPONSE] = FLOODSCORES(C,COUNTRYID,SCENARIOID) returns country
%   information for a given scenario.
%
%   [DATA,RESPONSE] = FLOODSCORES(C,COUNTRYID,SCENARIOID,VARARGIN) returns country
%   information given a list of API flags.
%   
%   DATA is a table containing the requested data and RESPONSE is a
%   ResponseMessage containing all the request response information.
%
%   For example,
%
%   [data,response] = floodscores(c,"GB")
%
%   returns
%
%   data =
%   
%     1x5 table
%   
%       count     pages        next            prev            data     
%       ______    _____    ____________    ____________    _____________
%   
%       342.00    18.00    {0x0 double}    {0x0 double}    {342x5 table}
%   
%   
%   response = 
%   
%     ResponseMessage with properties:
%   
%       StatusLine: 'HTTP/1.1 200 OK'
%       StatusCode: OK
%           Header: [1x8 matlab.net.http.HeaderField]
%             Body: [1x1 matlab.net.http.MessageBody]
%        Completed: 0
%   
%   data = floodscores(c,"GB","rcp45_2036-2040")
%
%   data =
%   
%     1x5 table
%   
%       index      startDate       country       endDate          id  
%       _____    ______________    _______    ______________    ______
%   
%       1.00     {'2007-12-01'}    {'USA'}    {'2009-07-01'}    116.00
%    
%   See also JBARISK.

%   Copyright 2023-2024 The MathWorks, Inc. 

% Create components for request
urlString = strcat(c.URL,"floodscores/",id);

% Add scenario if given
if exist("scenario","var") && ~isempty(scenario)
  urlString = strcat(urlString,"/scenario/",scenario);
end

% make request for data
if nargin < 4
  [data, response] = makeRequest(c,urlString);  
elseif isstruct(varargin{1}) || isscalar(varargin)
  [data, response] = makeRequest(c,urlString,varargin{1});
else
  [data, response] = makeRequest(c,urlString,[],varargin{:});
end