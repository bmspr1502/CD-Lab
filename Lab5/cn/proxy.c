#include "myheader.h"                                                                                                                                                   
                                                                                                                                                                        
int main(int argc, char *argv[]){                                                                                                                                       
        response sr;                                                                                                                                                    
        strcpy(sr.version, "http/1.1");                                                                                                                                 
        strcpy(sr.connection, "keep-alive");                                                                                                                            
        strcpy(sr.contype, "text");                                                                                                                                     

        struct sockaddr_in serveraddr;                                                                                                                                  
        int sockfd = socket(AF_INET, SOCK_STREAM, 0);                                                                                                                   
        serveraddr.sin_family = AF_INET;                                                                                                                                
        serveraddr.sin_port = htons(PORT);                                                                                                                              
        serveraddr.sin_addr.s_addr = inet_addr("127.0.0.1");                                                                                                            

        struct sockaddr_in origin;                                                                                                                                      
        int newsockfd = socket(AF_INET, SOCK_STREAM, 0);                                                                                                                
        origin.sin_family = AF_INET;                                                                                                                                    
        origin.sin_port = htons(PORT1);                                                                                                                                 
        origin.sin_addr.s_addr = htonl(INADDR_ANY);                                                                                                                     

        if (bind(sockfd, (struct sockaddr *) &serveraddr, sizeof(serveraddr)) < 0) return 0;                                                                            
        if (listen(sockfd, 2) < 0) return 0;                                                                                                                            
        printf("Proxy server listening on port: %d\n", PORT);                                                                                                           
                                                                                                                                                                        
        int clisock = accept(sockfd, NULL, NULL);                                                                                                                       
        if (clisock < 0) return 0;                                                                                                                                      

        if (connect(newsockfd, (struct sockaddr *) &origin, sizeof(origin)) < 0) { printf("er\n"); return 0;}                                                           

        FILE *inf;                                                                                                                                                      
        inf = fopen("cachestud.txt", "w+");                                                                                                                             

        while(1){                                                                                                                                                       
                request clr;                                                                                                                                            
                int len = recv(clisock, &clr, sizeof(clr), 0);                                                                                                          
                printf("CLIENT'S REQUEST:\n%s%s%s\nConnection: %s\nAccept: %s\nUser-Agent: %s\nRegno: %d\nRequired sem: %d\n",                                          
                        clr.method, clr.path, clr.version, clr.connection, clr.accept, clr.useragent, clr.stu.regno, clr.stu.sem);                                      

                if (clr.stu.regno == -1) break;                                                                                                                         

                student s;                                                                                                                                              
                int found = 0;                                                                                                                                          
                while(fread(&s, sizeof(student), 1, inf) == 1){                                                                                                         
                        if (s.regno == clr.stu.regno && s.sem == clr.stu.sem) {                                                                                         
                                found = 1;                                                                                                                              
                                printf("CACHE HIT !!!\n");                                                                                                              
                                sr.stu = s;                                                                                                                             
                                strcpy(sr.statmsg, "OK");
                                sr.status = 200;                                                                                                                        
                                break;                                                                                                                                  
                        }                                                                                                                                               
                }                                                                                                                                                       
                if (!found){                                                                                                                                            
                        printf("CACHE MISS !!! Requesting data from Origin Server.\n");                                                                                 
                        send(newsockfd, &clr, sizeof(clr), 0);                                                                                                          
                        int len = recv(newsockfd, &sr, sizeof(sr), 0);                                                                                                  
                        if (len > 0){                                                                                                                                   
                                if (sr.stu.regno != -1 && sr.stu.sem != -1){                                                                                            
                                        fwrite(&(sr.stu), sizeof(student), 1, inf);                                                                                     
                                }                                                                                                                                       
                        }                                                                                                                                               
                }                                                                                                                                                       
                time_t t = time(NULL);                                                                                                                                  
                struct tm *tm = localtime(&t);                                                                                                                          
                strcpy(sr.datetime, asctime(tm));                                                                                                                       
                printf("Current time: %s\n\n", sr.datetime);                                                                                                            
                send(clisock, &sr, sizeof(sr), 0);                                                                                                                      

                rewind(inf);                                                                                                                                            
        }                                                                                                                                                               
        fclose(inf);                                                                                                                                                    
        close(sockfd);                                                                                                                                                  
        return 0;                                                                                                                                                       
}