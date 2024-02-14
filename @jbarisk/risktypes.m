function [data, response] = risktypes(c,vulnerabilityset)
%RISKTYPES JBARisk risk type information.
%   [DATA,RESPONSE] = RISKTYPES(C,VULNERABILITYSET) returns risk type information 
%   for a specific vunerablity set.  VULNERABILITYSET is input as a scalar 
%   string or character vector.
%
%   For example,
%
%   [data,response] = risktypes(c,"UK")
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
%   See also JBARISK.

%   Copyright 2023-2024 The MathWorks, Inc. 

% Create base URL string
urlString = strcat(c.URL,"risktypes/",string(vulnerabilityset));

% make request for data, risktypes does not take api params or request body
[data, response] = makeRequest(c,urlString);  