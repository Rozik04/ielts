import { CanActivate, ExecutionContext, Injectable } from "@nestjs/common";
import { Reflector } from "@nestjs/core";
import {  JwtService } from "@nestjs/jwt";
import { Observable } from "rxjs";

@Injectable()
export class JwtAuthGuard implements CanActivate{
    constructor(private jwtService: JwtService, private reflector:Reflector ){}

    canActivate(context: ExecutionContext): boolean  {
        const request = context.switchToHttp().getRequest()
        const header = request.headers.authorization;
        if(!header){
            return false
        }
        const token = header.split(" ")[1]
        try {
            const data = this.jwtService.verify(token); 
            request.user = data; 
            return true;
        } catch (error) {
            return false;
        }
    }
}