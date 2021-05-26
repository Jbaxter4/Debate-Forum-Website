from flask import Flask, render_template, request, jsonify, session, url_for
import mysql.connector, string, random
from datetime import datetime
app = Flask(__name__)
app.secret_key = 'SS1FVGXPBAE3'
sql = mysql.connector.connect(user='root', password='Pj7nJ9Gfc9CnXRA!', host='127.0.0.1', database='comp5013')
cursor = sql.cursor()

@app.route('/')
@app.route('/home')
def home():
    cursor.execute("select * from topics")
    topics = cursor.fetchall()
    return render_template('home.html', topics=topics)

@app.route('/register', methods=['POST'])
def register():
    name = request.form['name']
    password = request.form['passw']
    if name and password:
        cursor.execute('select name from users where name = "%s"' % name)
        nameCheck = cursor.fetchall()
        if (len(nameCheck) > 0):
            return jsonify({'error' : 'A user with that name already exists'})
        sql_insertUser = "insert into users (id, name, password) values (null, %s, %s)"
        data = (name, password)
        cursor.execute(sql_insertUser, data)
        sql.commit()
        session["user"] = name
        return 'registered'
    return jsonify({'error' : 'Invalid entry'})

@app.route('/login', methods=['POST'])
def login():
    name = request.form['name']
    password = request.form['passw']
    if name and password:
        cursor.execute('select name from users where name = "%s" and password = "%s"' % (name, password))
        nameCheck = cursor.fetchall()
        if (len(nameCheck) > 0):
            for row in nameCheck:
                name = ''.join(str(x) for x in row)
            session["user"] = name
            return jsonify({'success' : name})
    return jsonify({'error' : 'Invalid username and password combination'})
    
@app.route('/logout', methods=['POST'])
def logout():
    session.pop('user', None)
    return 'logged out'
    
@app.route('/addTopic', methods=['POST'])
def addTopic():
    tName = request.form['tName']
    session['user'] = session.get('user')
    pName = session['user']
    if tName and pName:
        cursor.execute('select topicName from topics where topicName = "%s"' % tName)
        tNameCheck = cursor.fetchall()
        if (len(tNameCheck) > 0):
            return jsonify({'error' : 'A topic with that name already exists'})
        dateTime = datetime.now()
        sql_insertTopic = "insert into topics (topicID, topicName, posterName, posterTime) values (null, %s, %s, %s)"
        tData = (tName, pName, dateTime)
        cursor.execute(sql_insertTopic, tData)
        sql.commit()
        return 'topic created'
    return jsonify({'error' : 'Invalid topic name'})
    
@app.route('/topic/<topicName>', methods=['GET', 'POST'])
def topic(topicName):
    cursor.execute('select posterName from topics where topicName = "%s"' % topicName)
    topicPoster = cursor.fetchall()
    topicPoster = topicPoster[0][0]
    cursor.execute('select posterTime from topics where topicName = "%s"' % topicName)
    topicTime = cursor.fetchall()
    topicTime = topicTime[0][0]
    topicTime = topicTime.strftime("%Y-%m-%d %H:%M:%S")
    cursor.execute('select topicID from topics where topicName = "%s"' % topicName)
    topicID = cursor.fetchall()
    topicID = topicID[0][0]
    cursor.execute('select * from claims where parentTopic = "%s"' % topicID)
    claims = cursor.fetchall()
    return render_template('topic.html', claims=claims, poster=topicPoster, time=topicTime, name=topicName)

@app.route('/addClaim', methods=['POST'])
def addClaim():

    cHeader = request.form['cHeader']
    tName = request.form['tName']
    related = request.form['related']
    r = related.strip('[]')
    r = r.replace('"', '')
    related = r.split(',')
    oppEqu = request.form['oppEqu']
    o = oppEqu.strip('[]')
    o = o.replace('"', '')
    oppEqu = o.split(',')
    session['user'] = session.get('user')
    pName = session['user']
    if cHeader and pName and tName:
        cursor.execute('select claimHeader from claims where claimHeader = "%s"' % cHeader)
        cHeaderCheck = cursor.fetchall()
        if (len(cHeaderCheck) > 0):
            return jsonify({'error' : 'A claim with that header already exists'})
        cursor.execute('select topicID from topics where topicName = "%s"' % tName)
        topicID = cursor.fetchall()
        topicID = topicID[0][0]
        dateTime = datetime.now()
        sql_insertClaim = "insert into claims (claimID, claimHeader, posterName, posterTime, parentTopic) values (null, %s, %s, %s, %s)"
        cData = (cHeader, pName, dateTime, topicID)
        cursor.execute(sql_insertClaim, cData)
        sql.commit()
        cursor.execute('select claimID from claims where claimHeader = "%s"' % cHeader)
        claimID = cursor.fetchall()
        claimID = claimID[0][0]
        if related[0] != '':
            for i in related:
                j = related.index(i)
                cursor.execute('select claimID from claims where claimHeader = "%s"' % i)
                relatedID = cursor.fetchall()
                relatedID = relatedID[0][0]
                sql_insertClaimRel = 'insert into claimrelations (claimID, claimHeader, relatedToID, oppOrEqu) values (%s, %s, %s, %s)'
                cRelData = (claimID, cHeader, relatedID, oppEqu[j])
                cursor.execute(sql_insertClaimRel, cRelData)
                sql.commit()
                cursor.execute('select claimHeader from claims where claimID = "%s"' % relatedID)
                cAltHeader = cursor.fetchall()
                cAltHeader = cAltHeader[0][0]
                sql_insertClaimRel = 'insert into claimrelations (claimID, claimHeader, relatedToID, oppOrEqu) values (%s, %s, %s, %s)'
                cRelData = (relatedID, cAltHeader, claimID, oppEqu[j])
                cursor.execute(sql_insertClaimRel, cRelData)
                sql.commit()
        return 'claim created'
    return jsonify({'error' : 'Invalid claim header'})
    
@app.route('/claim/<claimID>', methods=['GET', 'POST'])
def claim(claimID):
    cursor.execute('select posterName from claims where claimID = "%s"' % claimID)
    claimPoster = cursor.fetchall()
    claimPoster = claimPoster[0][0]
    cursor.execute('select posterTime from claims where claimID = "%s"' % claimID)
    claimTime = cursor.fetchall()
    claimTime = claimTime[0][0]
    claimTime = claimTime.strftime("%Y-%m-%d %H:%M:%S")
    cursor.execute('select claimHeader from claims where claimID = "%s"' % claimID)
    claimHeader = cursor.fetchall()
    claimHeader = claimHeader[0][0]
    cursor.execute('select * from replys where parentClaim = "%s"' % claimID)
    replys = cursor.fetchall()
    cursor.execute('select * from claimRelations where relatedToID = "%s"' % claimID)
    relations = cursor.fetchall()
    return render_template('claim.html', relations=relations, replys=replys, poster=claimPoster, time=claimTime, header=claimHeader)

@app.route('/addReply', methods=['POST'])
def addReply():
    cHeader = request.form['cHeader']
    reply = request.form['reply']
    pReplyID = request.form['pReply']
    relation = request.form['relation']
    session['user'] = session.get('user')
    pName = session['user']
    cursor.execute('select claimID from claims where claimHeader = "%s"' % cHeader)
    cID = cursor.fetchall()
    cID = cID[0][0]
    dateTime = datetime.now()
    if pReplyID == "":
        if reply and pName and dateTime and cID and relation:
            sql_insertReply = "insert into replys (replyID, replyContent, posterName, posterTime, parentClaim, parentReply, claimResponse, replyResponse) values (null, %s, %s, %s, %s, null, %s, null)"
            rData = (reply, pName, dateTime, cID, relation)
            cursor.execute(sql_insertReply, rData)
            sql.commit()
            return 'reply created'
    else:
        if reply and pName and pReplyID and dateTime and cID and relation:
            sql_insertReply = "insert into replys (replyID, replyContent, posterName, posterTime, parentClaim, parentReply, claimResponse, replyResponse) values (null, %s, %s, %s, %s, %s, null, %s)"
            rData = (reply, pName, dateTime, cID, pReplyID, relation)
            cursor.execute(sql_insertReply, rData)
            sql.commit()
            return 'reply created'
    return jsonify({'error' : 'Invalid reply'})
    
@app.route('/search', methods=['GET', 'POST'])
def search():
    topics = ''
    claims = ''
    replys = ''
    if request.method == "POST":
        searchMethod = request.form['searchMethod']
        data = request.form['data']
        data = ''.join(('%', data, '%'))
        if searchMethod and data:
            if searchMethod == 'contains':
                cursor.execute('select * from topics where topicName like "%s"' % (data))
                topics = cursor.fetchall()
                cursor.execute('select * from claims where claimHeader like "%s"' % (data))
                claims = cursor.fetchall()
                cursor.execute('select * from replys where replyContent like "%s"' % (data))
                replys = cursor.fetchall()
                return render_template('search.html', topics=topics, claims=claims, replys=replys)
            elif searchMethod == 'author':
                cursor.execute('select * from topics where posterName like "%s"' % (data))
                topics = cursor.fetchall()
                cursor.execute('select * from claims where posterName like "%s"' % (data))
                claims = cursor.fetchall()
                cursor.execute('select * from replys where posterName like "%s"' % (data))
                replys = cursor.fetchall()
                return render_template('search.html', topics=topics, claims=claims, replys=replys)
    return render_template('search.html', topics=topics, claims=claims, replys=replys)

if __name__ == '__main__':
    app.run(debug=True)
