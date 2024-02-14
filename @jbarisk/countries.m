function [data, response] = countries(c,id,varargin)
%COUNTRIES JBARisk country information.
%   [DATA,RESPONSE] = COUNTRIES(C) returns all available country data 
%   information given the jbarisk object C.   
%
%   [DATA,RESPONSE] = COUNTRIES(C,ID) returns information for a specific
%   country.  ID is input as a scalar string or character vector.
%
%   [DATA,RESPONSE] = COUNTRIES(C,ID,VARARGIN) returns country
%   information given a list of API flags.
%   
%   DATA is a table containing the requested data and RESPONSE is a
%   ResponseMessage containing all the request response information.
%
%   For example,
%
%   [data,response] = countries(c)
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
%   data = countries(c,"US5")
%
%   data =
%   
%     1x5 table
%   
%           name           release_date    country    projection_code    resolution
%    __________________    ____________    _______    _______________    __________
%   
%     US5_202007_5m_4326       202007         US5           4326              5m    
%    
%   
%   reqStruct.geometries(1).id = "point 1";
%   reqStruct.geometries(1).wkt_geometry = "POINT(-101.1412927159555553 43.94424115485919)";
%   reqStruct.geeomtries(1).buffer = "10";
%   reqStruct.geometries(2).id = "point 2";
%   reqStruct.geometries(2).wkt_geometry = "POINT(-102.1412927159555553 42.94424115485919)";
%   reqStruct.geeomtries(2).buffer = "10";  
%
%   data,response = countries(c,"US5",reqStruct)
%
%   returns
%
%   data =
%
%     2x2 table
%   
%           id           stats   
%       ___________    __________
%   
%       {'point 1'}    1×1 struct
%       {'point 1'}    1×1 struct   
%
% See also JBARISK.

%   Copyright 2023-2024 The MathWorks, Inc. 

% Create components for request
urlString = strcat(c.URL,"countries");

% Add country ID if given
if exist("id","var")  && ~isempty(id)
    
  % Create base URL string
  urlString = strcat(urlString,"/",id);

end

% make request for data
if nargin < 3
  [data, response] = makeRequest(c,urlString);  
elseif isstruct(varargin{1}) || isscalar(varargin)
  [data, response] = makeRequest(c,urlString,varargin{1});
else
  [data, response] = makeRequest(c,urlString,[],varargin{:});
end


