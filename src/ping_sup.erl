%%%-------------------------------------------------------------------
%% @doc ping top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(ping_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
  io:format("Ping supervisor is started........~n"),
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%%%====================================================================
%%%% Supervisor callbacks
%%%%====================================================================
%%
%%%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}

init([]) ->



  %% DataBaseServer Configuration One
  DataBaseServer = {database_server, {database_server, start_link, []},
    permanent, 2000, worker, [database_server]},

  Children = [DataBaseServer],
  RestartStrategy = {one_for_all, 0, 1},
  {ok, {RestartStrategy, Children}}.

%%====================================================================
%% Internal functions
%%====================================================================
