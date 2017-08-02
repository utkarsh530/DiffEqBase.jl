type RODEProblem{uType,tType,isinplace,NP,F,C,MM,ND} <: AbstractRODEProblem{uType,tType,isinplace,ND}
  f::F
  u0::uType
  tspan::Tuple{tType,tType}
  noise::NP
  callback::C
  mass_matrix::MM
  rand_prototype::ND
  seed::UInt64
  function RODEProblem{isinplace}(f,u0,tspan;
                       rand_prototype = nothing,
                       noise= nothing, seed = UInt64(0),
                       callback=nothing,mass_matrix=I) where {isinplace}
  new{typeof(u0),promote_type(map(typeof,tspan)...),
              isinplace,typeof(noise),typeof(f),typeof(callback),
              typeof(mass_matrix),typeof(rand_prototype)}(
              f,u0,tspan,noise,callback,mass_matrix,rand_prototype,seed)
  end
end

function RODEProblem(f,u0,tspan;kwargs...)
  iip = typeof(f)<: Tuple ? isinplace(f[2],4) : isinplace(f,4)
  RODEProblem{iip}(f,u0,tspan;kwargs...)
end
