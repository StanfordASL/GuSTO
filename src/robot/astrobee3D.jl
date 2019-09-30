export Astrobee3D

mutable struct Astrobee3D{T<:AbstractFloat} <: Robot
  mass::T
  J::Matrix{T}
  Jinv::Matrix{T}
  n_thrusters::Int
  r::T
  hard_limit_vel::T
  hard_limit_accel::T 
  hard_limit_omega::T
  hard_limit_alpha::T
  btCollisionObject
end
function Astrobee3D{T}() where T
  n_thrusters = 12
  s = 0.5*0.305   # each side of cube is 30.5cm
  r = sqrt(3)*s   # inflate to sphere

  # flight robot param: freeflyer/astrobee/config/world/iss.config
  mass = 7.2 # 7.0 
  hard_limit_vel = 0.15 # 0.5 # Actual limit: 0.5
  hard_limit_accel = 0.1 
  hard_limit_omega = 0.1*45*pi/180 
  hard_limit_alpha = 50*pi/180 
 
  J = 0.1083*eye(3) 
  Jinv = inv(J)

  btCollisionObject = BulletCollision.sphere(SVector{3}(zeros(T,3)), r)

  # new astrobee instance
  return Astrobee3D{T}(mass, J, Jinv, n_thrusters, r, hard_limit_vel, hard_limit_accel, hard_limit_omega, hard_limit_alpha,btCollisionObject)
end
Astrobee3D(::Type{T} = Float64; kwargs...) where {T} = Astrobee3D{T}(; kwargs...)
