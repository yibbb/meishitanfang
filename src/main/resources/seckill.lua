---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by 321.
--- DateTime: 2023/3/21 17:37
---
--优惠券id
local voucherId=ARGV[1]
--用户id
local userId=ARGV[2]
--库存key
local stockKey="seckill:stock:"..voucherId
--订单key
local orderKey="seckill:order:"..voucherId

--判断库存是否充足 get stockKey
if(tonumber(redis.call('get',stockKey))<=0) then
    --库存不足
    return 1
end
--判断用户是否下单 SISMEMBER orderKey userId
if (redis.call('sismember',orderKey,userId)==1) then
    return 2
end
--扣库存
redis.call('incrby',stockKey,-1)
--下单（保存用户）
redis.call('sadd',orderKey,userId)
return 0

