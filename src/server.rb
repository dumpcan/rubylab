require 'sinatra'
require_relative 'service'
require_relative 'tasks/evaluator'

CONFIG_PATH = "config"
service = RubyLab::Service.new CONFIG_PATH

before do
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST','PUT'],
          'Access-Control-Allow-Headers' => ['Content-Type', "x-requested-with", "origin"]
end
set :protection, false

options '/*' do
  response["Access-Control-Allow-Headers"] = "origin, x-requested-with, content-type"
end

put '/tasks/:task_id/evaluate' do
  solution_string = request.body.read;
  service.eval_solution(params[:task_id], solution_string)
end

get '/tasks/:task_id/worksheet' do
  content_type 'text/plain'
  service.worksheet_of(params[:task_id])
end
