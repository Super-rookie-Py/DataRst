# Queue Simulation 2019/11/20 by SeJoon Park
setwd("C:/Users/sonmu/Desktop/Class/데이터 구조론/2020 1학기 데이터 구조론/Program file")


set.seed(1234)

Simulation_Length = 24 * 60
Big_M=Simulation_Length * 2

result_temp<-data.frame(Current_Time=0,Queue_Length=0,System_Status="Not Busy")

Next_Arrival_Time = Big_M
Service_End = Big_M

C_T=0 # current time
N_Q=0 # current Queue length
A_T=1 # interarrival time (parameter)
S_T=2 # service time (parameter)
Next_Arrival_Time = rexp(1,A_T)

result<-result_temp

S_S="Not Busy"
i=1
System_Utility=0

repeat{
  if(C_T>Simulation_Length){
    break
  }  
  
  if(Next_Arrival_Time>Service_End){
    N_Q=N_Q-1
    C_T=Service_End
    if(N_Q>0){
      Service_End=C_T+rexp(1,S_T)
      S_S="Busy"
    }else{
      Service_End=Big_M
      S_S="Not Busy"
    }
  }else{
    N_Q=N_Q+1
    C_T=Next_Arrival_Time
    Next_Arrival_Time=C_T+rexp(1,A_T)
    if(N_Q==1){
      Service_End=C_T+rexp(1,S_T)
      S_S="Busy"
    }
  }
  result_temp$Current_Time=C_T
  result_temp$Queue_Length=N_Q
  result_temp$System_Status=S_S
  result<-rbind(result,result_temp)
  print(result_temp)
  
  i=i+1
  if(result$System_Status[i-1]=="Busy"){
    System_Utility=System_Utility+result$Current_Time[i]-result$Current_Time[i-1]
  }
}

write.csv(result,'Queue_Simulation.csv')
System_Utility=System_Utility/Simulation_Length
print(System_Utility)

