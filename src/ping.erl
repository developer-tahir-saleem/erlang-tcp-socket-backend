%%%-------------------------------------------------------------------
%% @doc ping public API
%% @end
%%%-------------------------------------------------------------------

-module(ping).

-behaviour(application).

%% Application callbacks
-export([start/0, start/2, stop/1, checkJson/1, stop/0]).

%%====================================================================
%% API
%%====================================================================

start() ->
  application:start(compiler),
  %% Start eSockd application
  ok = esockd:start(),
  Options = [{acceptors, 10},
    {max_clients, 1024},
    {sockopts, [binary, {reuseaddr, true}]}],
  MFArgs = {socket_server, start_link, []},

  esockd:open(echo, 9090, Options, MFArgs),
  application:start(?MODULE).



start(_StartType, _StartArgs) ->
  ping_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
  ok.

%%--------------------------------------------------------------------

stop() ->
  application:stop(?MODULE).


checkJson(Signal) ->
  {JSON} = jiffy:encode(Signal),
  io:format("Here is Json ~p ~n", [JSON]).

%%====================================================================
%% Internal functions
%%====================================================================
