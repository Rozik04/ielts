import multer from "multer"
import { extname } from "path";

const storage = multer.diskStorage({
    destination:(req, file, cb) =>{
        cb(null, 'uploads');
    },
    filename:(req, file, cb) =>{
        cb(null, `${Date.now()}${extname(file.originalname)}`);
    }
})

export let upload = multer({storage});